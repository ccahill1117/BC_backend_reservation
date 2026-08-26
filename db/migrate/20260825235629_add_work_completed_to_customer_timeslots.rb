class AddWorkCompletedToCustomerTimeslots < ActiveRecord::Migration[8.1]
  def change
    add_column :customer_timeslots, :work_completed, :boolean, null: false, default: false
  end
end
