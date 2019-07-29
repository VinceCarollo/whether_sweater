require 'rails_helper'

RSpec.describe 'Munchies API' do
  it "can get time to travel and restaurants matching genre given" do
    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese', headers: headers

    expect(response).to be_successful

    expected = {
      end_city: 'pueblo, co'
      travel_time:
    }

    travel_data = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(travel_data).to have_key(:end_city)
    expect(travel_data).to have_key(:travel_time)
    expect(travel_data[:restaurants]).to be a Array
    expect(travel_data[:restaurants].count).to eq(3)
    expect(travel_data[:restaurants].first).to have_key(:name)
    expect(travel_data[:restaurants].first).to have_key(:address)
  end
end
