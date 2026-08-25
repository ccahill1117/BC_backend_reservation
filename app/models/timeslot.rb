class Timeslot < ApplicationRecord
  has_one :customer_timeslot, dependent: :destroy

  validates :start_time, presence: true, uniqueness: true
  validates :end_time, presence: true
end
