Rails.application.routes.draw do
  # Defines the root path route ("/")
  get "/timeslots" => "timeslots#index"
end

