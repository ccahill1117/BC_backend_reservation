class CreateCustomerTimeslots < ActiveRecord::Migration[8.1]
  def change
    create_table :customer_timeslots do |t|
      t.string :customer_info
      t.string :vehicle_info
      t.integer :timeslot

      t.timestamps
    end
  end
end
