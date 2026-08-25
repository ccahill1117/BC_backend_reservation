## BizzyCar Technical Assessment - Backend (RoR)

### Architecture Decisions
- Keeping DB simple with zero-config SQLite
- Assume every appointment is one-hour in duration


### Local Config and Setup for This Project
- $ bundle install
- $ rails db:migrate
- $ rails db:seed 
  - this command will 8, 1-hr timeslots for the current day (in UTC)

### How To Use This App (locally)

- After running the above install, config, and seeding commands, the following endpoint will give you the available timeslots:
  - GET http://localhost:3000/timeslots

- Once you have the ID of an available timeslot, use the following endpoint to book 
  - POST http://localhost:3000/customer_timeslot/:id

- If you want to delete any of the timeslots (say during lunch hour, or for other business reasons):
  - DELETE http://localhost:3000/timeslots/:id
    - if that timeslot exists, it will be deleted (along with an associated customer_timeslot, if there is one)

### Relevant Library Versions
* Ruby 3.4.7
* Rails 8.1.3.1
* SQLite 2.1

### Ai Usage
- 


* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
