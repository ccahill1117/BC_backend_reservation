class Timeslot < ApplicationRecord
  has_many :customer_timeslots

  validates :start_time, presence: true, uniqueness: true
  validates :end_time, presence: true
end
