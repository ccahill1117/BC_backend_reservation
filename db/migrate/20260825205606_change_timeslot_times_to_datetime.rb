class ChangeTimeslotTimesToDatetime < ActiveRecord::Migration[8.1]
  def change
    change_column :timeslots, :start_time, :datetime
    change_column :timeslots, :end_time, :datetime
  end
end
