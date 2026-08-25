class CustomerTimeslotsController < ApplicationController
  def book
    timeslot = Timeslot.find_by(id: params[:timeslot_id])

    # return with error if no timeslot_id found
    unless timeslot
      return render json: { message: "timeslot id not found" }, status: :not_found
    end

    # create new customer_timeslot from params
    customer_timeslot = CustomerTimeslot.new(
      timeslot_id: timeslot.id,
      customer_info: params[:customer_info],
      vehicle_info: params[:vehicle_info]
    )

    if customer_timeslot.save
      render json: customer_timeslot, status: :created
    else
      render json: { errors: customer_timeslot.errors.full_messages }, status: :unprocessable_content
    end
  end
end
