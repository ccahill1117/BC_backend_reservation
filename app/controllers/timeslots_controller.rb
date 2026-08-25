class TimeslotsController < ApplicationController
  def index
    @timeslots = Timeslot.all
    # return as json
    render json: @timeslots
  end

  def destroy
    timeslot = Timeslot.find_by(id: params[:id])

    if timeslot
      timeslot.destroy
      render json: { message: "timeslot successfully deleted" }
    else
      render json: { message: "timeslot id not found" }, status: :not_found
    end
  end

end
