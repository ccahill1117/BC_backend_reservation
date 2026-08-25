class CustomerTimeslot < ApplicationRecord
  belongs_to :timeslot

  validates :timeslot_id, uniqueness: true
  validates :customer_info, presence: true
  validates :vehicle_info, presence: true
end
