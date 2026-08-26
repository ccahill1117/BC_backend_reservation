Rails.application.routes.draw do
  # Front end can get all timeslots, with customer_timeslots included
  get "/timeslots" => "timeslots#index"
  # book a customer_timeslot for a timeslot, with timeslot.id as param
  post "/customer_timeslots" => "customer_timeslots#book"
  # delete timeslots by id
  delete "/timeslots/:id" => "timeslots#destroy"
  # delete cusomter_timeslots by id
  delete "/customer_timeslots/:id" => "customer_timeslots#destroy"
  # update customer_timeslot work_completed status by id
  # PATCH here is rails convention
  patch "/customer_timeslots/:id" => "customer_timeslots#update"
end
