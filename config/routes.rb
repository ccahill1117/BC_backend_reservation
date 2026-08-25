Rails.application.routes.draw do
  # Defines the root path route ("/")
  get "/timeslots" => "timeslots#index"
  delete "/timeslots/:id" => "timeslots#destroy"
end

