class TimeslotsController < ApplicationController
  def index
    @timeslots = Timeslot.all
    # return as json
    render json: @timeslots
  end
end
