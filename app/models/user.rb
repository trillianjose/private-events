class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessor :remember_token

  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  has_many :owner_relationships, -> { where(role: 'owner') }, class_name: 'Attendance'
  has_many :events_as_owner, through: :owner_relationships, source: :event

  has_many :assistent_relationships, -> { where(role: 'assistent') }, class_name: 'Attendance'
  has_many :events_as_assistent, through: :assistent_relationships, source: :event

  before_save :downcase_email

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                 BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def assistent?(event)
    events_as_assistent.include? event
  end

  private

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end
end
