class Attendance < ApplicationRecord
  enum role: [:owner, :assistent]

  belongs_to :user
  belongs_to :event
end
