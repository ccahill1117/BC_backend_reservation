# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_08_23_085508) do
  create_table "customer_timeslots", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "customer_info"
    t.integer "timeslot_id", null: false
    t.datetime "updated_at", null: false
    t.string "vehicle_info"
    t.index ["timeslot_id"], name: "index_customer_timeslots_on_timeslot_id", unique: true
  end

  create_table "timeslots", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.time "end_time", null: false
    t.time "start_time", null: false
    t.datetime "updated_at", null: false
    t.index ["start_time"], name: "index_timeslots_on_start_time", unique: true
  end

  add_foreign_key "customer_timeslots", "timeslots"
end
