require "rails_helper"

RSpec.describe "CustomerTimeslots", type: :request do
  describe "POST /customer_timeslots" do
    let(:timeslot) { Timeslot.create!(start_time: Time.zone.now, end_time: Time.zone.now + 1.hour) }

    it "creates a customer_timeslot associated with the given timeslot" do
      post "/customer_timeslots", params: {
        customer_info: "John Smith",
        vehicle_info: "Ford E-150",
        timeslot_id: timeslot.id
      }

      expect(response).to have_http_status(:created)
      body = JSON.parse(response.body)
      expect(body["timeslot_id"]).to eq(timeslot.id)
      expect(body["customer_info"]).to eq("John Smith")
      expect(body["vehicle_info"]).to eq("Ford E-150")

      expect(timeslot.reload.customer_timeslot).to be_present
    end

    it "returns 404 with a not found message when the timeslot does not exist" do
      post "/customer_timeslots", params: {
        customer_info: "John Smith",
        vehicle_info: "Ford E-150",
        timeslot_id: 999999
      }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({ "message" => "timeslot id not found" })
    end

    it "rejects a second booking for the same timeslot" do
      CustomerTimeslot.create!(
        timeslot_id: timeslot.id,
        customer_info: "Existing Customer",
        vehicle_info: "Toyota Camry"
      )

      post "/customer_timeslots", params: {
        customer_info: "John Smith",
        vehicle_info: "Ford E-150",
        timeslot_id: timeslot.id
      }

      expect(response).to have_http_status(:unprocessable_content)
      body = JSON.parse(response.body)
      expect(body["errors"]).to include("Timeslot has already been taken")

      expect(CustomerTimeslot.where(timeslot_id: timeslot.id).count).to eq(1)
      expect(CustomerTimeslot.find_by(timeslot_id: timeslot.id).customer_info).to eq("Existing Customer")
    end
  end
end
