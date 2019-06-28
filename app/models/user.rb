class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :owner_relationships, ->{ where(role: 'owner') }, class_name: 'Attendance'
  has_many :events_as_owner, through: :owner_relationships, source: :event

  has_many :assistent_relationships, ->{ where(role: 'assistent') }, class_name: 'Attendance'
  has_many :events_as_assistent, through: :assistent_relationships, source: :event

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
end
