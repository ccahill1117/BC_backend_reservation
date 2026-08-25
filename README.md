## BizzyCar Technical Assessment - Backend (RoR)

### Architecture Decisions
- Keeping DB simple with zero-config SQLite
- Assume every appointment is one-hour in duration
- Seed database with a function that creats 8x 1-hour long appointments on that calendar day
  - Running that twice will not create additional timeslots due to being seed file
- Keep models small and simple 
  - Timeslot: id, start_time(datetime), end_time(datetime), created_at(datetime), updated_at(datetime)
  - CustomerTimeslot: id, customer_info(varchar), vehicle_info(varchar), created_at(datetime), updated_at(datetime), timeslot_id(int references Timeslot)
- Add basic functionality to create CustomerTimeslots, delete CustomerTimeslots, and delete Timeslots.

### Local Config and Setup for This Project
- $ bundle install
- $ rails db:migrate
- $ rails db:seed 
  - this command will create 8x, 1-hr timeslots for the current day running the hours of 0900-1700 (in UTC)
- $ rails server

### How To Use This App (locally)

- After running the above install, config, and seeding commands, the following endpoint will give you the Timeslots, with CustomerTimeslots included as well:
  - GET http://localhost:3000/timeslots
  - ![GET timeslots index](public/get_timeslots_index.jpg)
- Once you have the ID of an available timeslot, use the following endpoint to book an appointment (customer_timeslot) with the following JSON body
  - POST http://localhost:3000/customer_timeslots
    ```json
    {
      "customer_info": "John Smith",
      "vehicle_info": "Ford E-150",
      "timeslot_id": 48
    }
    ```
  - ![POST customer_timeslots](public/post_customer_timeslot.jpg)
- If you want to delete any of the timeslots (say during lunch hour, or for other business reasons):
  - DELETE http://localhost:3000/timeslots/:timeslot_id
    - if that timeslot exists, it will be deleted (along with an associated customer_timeslot, if there is one)
- If you want to delete any customer_timeslot (maybe someone canceled, etc.):
  - DELETE http://localhost:3000/customer_timeslots/:customer_timeslot_id
- ![DELETE customer_timeslots](public/delete_customer_timeslots.jpg)
- If you want to delete all Timeslots and CustomerTimeslots and start over with fresh Timeslot data:
  - (in rails console) $ Timeslot.destroy_all
  - (in project root bash) $ rails db:seed

### Testing (RSpec)
- I am using RSpec for testing the controllers in this app
- I did not add unit tests for models since they are so small
- The test suite can be run via:
  - $ bundle exec rspec
  or, for verbose results: 
  - $ bundle exec rspec --format documentation

- For GUI-assistance to see the records easily, I used DB Browser for SQLite, which you can install with the following command 
  - $ brew install --cask db-browser-for-sqlite
- After installation, simply click "Open Database", and open the .sqlite3 file located in storage/development.sqlite3
  - see below example: 
  - ![DB Browser for SQLite](public/db_browser_for_sqlite.jpg)

### Relevant Library Versions
* Ruby 3.4.7
* Rails 8.1.3.1
* SQLite 2.1
* Rspec for unit tests
* Rubocop for linting

### Ai Usage
- I utilized Claude Code throughout the development of this app. I mostly used Claude to create some boilerplate for the first model (timeslots), and then copied and pasted a bit.
- I additionally used Claude for a bit of the controller code, which for certain routes I then copied and pasted.
- I heavily used Claude to write the rspec tests against the controllers, and focused more of my manual (Postman) testing on application code.

