class CustomerTimeslot < ApplicationRecord
  belongs_to :timeslot

  validates :timeslot_id, uniqueness: true
end
