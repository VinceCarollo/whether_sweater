require 'rails_helper'

RSpec.describe "Road Trip API" do
  it "gets weather info regarding road trip" do
    user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    post '/api/v1/users', params: user.to_json, headers: headers

    api_key = JSON.parse(response.body, symbolize_names: true)[:body][:api_key]

    request = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": api_key
    }

    post '/api/v1/road_trip', params: request.to_json, headers: headers

    forecast = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(forecast).to have_key(:origin)
    expect(forecast).to have_key(:destination)
    expect(forecast).to have_key(:travel_time)
  end

  it "requires correct api_key" do
    request = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": 'invalid_key'
    }

    post '/api/v1/road_trip', params: request.to_json, headers: headers

    error = JSON.parse(response.body, symbolize_names: true)

    expect(status).to eq(401)
    expect(error[:description]).to eq("Not Authorized")
    expect(error[:status]).to eq(401)
  end
end
