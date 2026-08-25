class TimeslotsController < ApplicationController
  def index
    @timeslots = Timeslot.all # Fetches data to pass to the view
  end
end


