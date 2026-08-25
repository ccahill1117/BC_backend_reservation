class TimeslotsController < ApplicationController
  def index
    @timeslots = Timeslot.includes(:customer_timeslot)
    # return as json, including the associated customer_timeslot
    render json: @timeslots, include: :customer_timeslot
  end

  def destroy
    timeslot = Timeslot.find_by(id: params[:id])
    # if we find a timeslot via id, then destroy, otherwise return message not found
    if timeslot
      timeslot.destroy
      render json: { message: "timeslot successfully deleted" }
    else
      render json: { message: "timeslot id not found" }, status: :not_found
    end
  end
end
