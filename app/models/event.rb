class Event < ApplicationRecord
  validates :title, :schedule, :description, presence: true

  validate :creation_date_cannot_past_date

  has_one :owner_relationship, ->{ where(role: 'owner') }, class_name: 'Attendance'
  has_one :owner, through: :owner_relationship, source: :user

  has_many :assistent_relationships, ->{ where(role: 'assistent') }, class_name: 'Attendance'
  has_many :assistents, through: :assistent_relationships, source: :user

  # def self.past
  #   where("schedule < ?", Date.today)
  # end
  scope :past, -> {where("schedule < ?", Date.today)}
  scope :upcoming, -> {where("schedule >= ?", Date.today)}

  private

  def creation_date_cannot_past_date
    if schedule.present? && schedule < Date.today
      errors.add(:schedule, "can't be in the past")
    end
  end

end
