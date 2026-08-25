require "rails_helper"

RSpec.describe "Timeslots", type: :request do
  describe "GET /timeslots" do
    it "returns all timeslots as json" do
      timeslot = Timeslot.create!(start_time: Time.zone.now, end_time: Time.zone.now + 1.hour)

      get "/timeslots"

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body.length).to eq(1)
      expect(body.first["id"]).to eq(timeslot.id)
    end

    it "includes the associated customer_timeslot when one exists" do
      timeslot = Timeslot.create!(start_time: Time.zone.now, end_time: Time.zone.now + 1.hour)
      customer_timeslot = CustomerTimeslot.create!(
        timeslot_id: timeslot.id,
        customer_info: "Jane Doe",
        vehicle_info: "Honda Civic"
      )

      get "/timeslots"

      body = JSON.parse(response.body)
      expect(body.first["customer_timeslot"]["id"]).to eq(customer_timeslot.id)
      expect(body.first["customer_timeslot"]["customer_info"]).to eq("Jane Doe")
    end

    it "returns null customer_timeslot when timeslot is unbooked" do
      Timeslot.create!(start_time: Time.zone.now, end_time: Time.zone.now + 1.hour)

      get "/timeslots"

      body = JSON.parse(response.body)
      expect(body.first["customer_timeslot"]).to be_nil
    end

    it "returns an empty array when there are no timeslots" do
      get "/timeslots"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([])
    end
  end

  describe "DELETE /timeslots/:id" do
    it "deletes the timeslot and returns a success message" do
      timeslot = Timeslot.create!(start_time: Time.zone.now, end_time: Time.zone.now + 1.hour)

      delete "/timeslots/#{timeslot.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq({ "message" => "timeslot successfully deleted" })
      expect(Timeslot.exists?(timeslot.id)).to be(false)
    end

    it "also destroys an associated customer_timeslot" do
      timeslot = Timeslot.create!(start_time: Time.zone.now, end_time: Time.zone.now + 1.hour)
      customer_timeslot = CustomerTimeslot.create!(
        timeslot_id: timeslot.id,
        customer_info: "Jane Doe",
        vehicle_info: "Honda Civic"
      )

      delete "/timeslots/#{timeslot.id}"

      expect(response).to have_http_status(:ok)
      expect(CustomerTimeslot.exists?(customer_timeslot.id)).to be(false)
    end

    it "returns 404 with a not found message when the timeslot does not exist" do
      delete "/timeslots/999999"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({ "message" => "timeslot id not found" })
    end
  end
end
