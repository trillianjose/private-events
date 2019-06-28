class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :attendances
  has_many :events, :through => :attendances

  has_many :event_as_owner, :through => :role { where(:role => 'owner') }, :source => :attendances
  has_many :event_as_assistent, :through => :role { where(:role => 'assistent') }, :source => :attendances


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
