class AddTimeslotRefToCustomerTimeslots < ActiveRecord::Migration[8.1]
  def change
    remove_column :customer_timeslots, :timeslot, :integer
    add_reference :customer_timeslots, :timeslot, null: false, foreign_key: true
  end
end
