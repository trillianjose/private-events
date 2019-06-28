class Event < ApplicationRecord
  validates :title, :schedule, :description, presence: true

  has_one :owner_relationship, ->{ where(role: 'owner') }, class_name: 'Attendance'
  has_one :owner, through: :owner_relationship, source: :user

  has_many :assistent_relationships, ->{ where(role: 'assistent') }, class_name: 'Attendance'
  has_many :assistents, through: :assistent_relationships, source: :user
end
