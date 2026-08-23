class AddUniqueIndexToCustomerTimeslotsTimeslotId < ActiveRecord::Migration[8.1]
  def change
    remove_index :customer_timeslots, :timeslot_id
    add_index :customer_timeslots, :timeslot_id, unique: true
  end
end
