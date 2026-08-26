require "rails_helper"

RSpec.describe "CustomerTimeslots", type: :request do
  let(:timeslot) { Timeslot.create!(start_time: Time.zone.now, end_time: Time.zone.now + 1.hour) }

  describe "POST /customer_timeslots" do
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

    it "rejects a booking with blank customer_info" do
      post "/customer_timeslots", params: {
        customer_info: "",
        vehicle_info: "Ford E-150",
        timeslot_id: timeslot.id
      }

      expect(response).to have_http_status(:unprocessable_content)
      body = JSON.parse(response.body)
      expect(body["errors"]).to include("Customer info can't be blank")
      expect(CustomerTimeslot.where(timeslot_id: timeslot.id)).to be_empty
    end

    it "rejects a booking with blank vehicle_info" do
      post "/customer_timeslots", params: {
        customer_info: "John Smith",
        vehicle_info: "",
        timeslot_id: timeslot.id
      }

      expect(response).to have_http_status(:unprocessable_content)
      body = JSON.parse(response.body)
      expect(body["errors"]).to include("Vehicle info can't be blank")
      expect(CustomerTimeslot.where(timeslot_id: timeslot.id)).to be_empty
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

  describe "PATCH /customer_timeslots/:id" do
    it "updates work_completed to true" do
      customer_timeslot = CustomerTimeslot.create!(
        timeslot_id: timeslot.id,
        customer_info: "Jane Doe",
        vehicle_info: "Honda Civic"
      )

      patch "/customer_timeslots/#{customer_timeslot.id}", params: { work_completed: true }

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["work_completed"]).to eq(true)
      expect(customer_timeslot.reload.work_completed).to be(true)
    end

    it "updates work_completed back to false" do
      customer_timeslot = CustomerTimeslot.create!(
        timeslot_id: timeslot.id,
        customer_info: "Jane Doe",
        vehicle_info: "Honda Civic",
        work_completed: true
      )

      patch "/customer_timeslots/#{customer_timeslot.id}", params: { work_completed: false }

      expect(response).to have_http_status(:ok)
      expect(customer_timeslot.reload.work_completed).to be(false)
    end

    it "returns 404 with a not found message when the customer_timeslot does not exist" do
      patch "/customer_timeslots/999999", params: { work_completed: true }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({ "message" => "customer timeslot id not found" })
    end
  end

  describe "DELETE /customer_timeslots/:id" do
    it "deletes the customer_timeslot and returns a success message" do
      customer_timeslot = CustomerTimeslot.create!(
        timeslot_id: timeslot.id,
        customer_info: "Jane Doe",
        vehicle_info: "Honda Civic"
      )

      delete "/customer_timeslots/#{customer_timeslot.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq({ "message" => "customer timeslot successfully deleted" })
      expect(CustomerTimeslot.exists?(customer_timeslot.id)).to be(false)
    end

    it "does not delete the associated timeslot" do
      customer_timeslot = CustomerTimeslot.create!(
        timeslot_id: timeslot.id,
        customer_info: "Jane Doe",
        vehicle_info: "Honda Civic"
      )

      delete "/customer_timeslots/#{customer_timeslot.id}"

      expect(Timeslot.exists?(timeslot.id)).to be(true)
    end

    it "returns 404 with a not found message when the customer_timeslot does not exist" do
      delete "/customer_timeslots/999999"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({ "message" => "customer timeslot id not found" })
    end
  end
end
