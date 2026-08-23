class CreateTimeslots < ActiveRecord::Migration[8.1]
  def change
    create_table :timeslots do |t|
      t.time :start_time, null: false
      t.time :end_time, null: false

      t.timestamps
    end

    add_index :timeslots, :start_time, unique: true
  end
end
