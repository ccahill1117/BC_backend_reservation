class CustomerTimeslotsController < ApplicationController
  def book
    timeslot = Timeslot.find_by(id: params[:timeslot_id])
    puts timeslot
    render json: { ts: timeslot }

  end

end
