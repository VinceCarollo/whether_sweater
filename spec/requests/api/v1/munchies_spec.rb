require 'rails_helper'

RSpec.describe 'Munchies API' do
  it "can get time to travel and restaurants upon arrival" do
    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    get '/api/v1/munchies?start=denver,co&end=new york,ny&food=chinese', headers: headers

    expect(response).to be_successful

    travel_data = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(travel_data).to have_key(:origin)
    expect(travel_data).to have_key(:destination)
    expect(travel_data).to have_key(:travel_time)
    expect(travel_data[:restaurants]).to be_a Array
    expect(travel_data[:restaurants].count).to eq(3)
    expect(travel_data[:restaurants].first).to have_key(:name)
    expect(travel_data[:restaurants].first).to have_key(:street_address)
    expect(travel_data[:restaurants].first).to have_key(:city)
    expect(travel_data[:restaurants].first).to have_key(:zip)
  end

  it "can get time to travel and restaurants upon arrival to different city" do
    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    get '/api/v1/munchies?start=denver,co&end=kansas city,mo&food=bbq', headers: headers

    expect(response).to be_successful

    travel_data = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(travel_data).to have_key(:origin)
    expect(travel_data).to have_key(:destination)
    expect(travel_data).to have_key(:travel_time)
    expect(travel_data[:restaurants]).to be_a Array
    expect(travel_data[:restaurants].count).to eq(3)
    expect(travel_data[:restaurants].first).to have_key(:name)
    expect(travel_data[:restaurants].first).to have_key(:street_address)
    expect(travel_data[:restaurants].first).to have_key(:city)
    expect(travel_data[:restaurants].first).to have_key(:zip)
  end

  it "gives 404 for bad input", :vcr do
    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    get '/api/v1/munchies?start=denver,co', headers: headers

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:status]).to eq(404)
    expect(error[:description]).to eq('Not Found')
  end
end
