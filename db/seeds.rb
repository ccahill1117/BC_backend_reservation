# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.

# seed function below create 8, UTC-based, 1-hour timeslots beginning at 0900, and ending at 1700
(9..16).each do |hour|
  Timeslot.find_or_create_by!(start_time: Time.now.utc.change(hour: hour, min: 0)) do |timeslot|
    timeslot.end_time = Time.now.utc.change(hour: hour + 1, min: 0)
  end
end
