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
      # if a customer has already booked that timeslot, then return has already been taken
      render json: { errors: customer_timeslot.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    customer_timeslot = CustomerTimeslot.find_by(id: params[:id])
    # if we find the customer_timeslot via :id, then update, if not return error to front end
    unless customer_timeslot
      return render json: { message: "customer timeslot id not found" }, status: :not_found
    end

    if customer_timeslot.update(work_completed: params[:work_completed])
      render json: customer_timeslot
    else
      render json: { errors: customer_timeslot.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    customer_timeslot = CustomerTimeslot.find_by(id: params[:id])
    # if we find the customer_timeslot via :id, then delete, if not return error to front end
    if customer_timeslot
      customer_timeslot.destroy
      render json: { message: "customer timeslot successfully deleted" }
    else
      render json: { message: "customer timeslot id not found" }, status: :not_found
    end
  end
end
