require 'rails_helper'

RSpec.describe GoogleService do
  it "can get location data", :vcr do
    location_data = GoogleService.location_data('kansas city, mo')

    location = location_data[:results].first[:geometry][:location]

    expect(location).to have_key(:lat)
    expect(location).to have_key(:lng)
  end

  it "can get travel time", :vcr do
    travel_time_data = GoogleService.travel_time('denver,co', 'kansas city,mo')

    travel_time = travel_time_data[:routes].first[:legs].first

    expect(travel_time).to have_key(:start_address)
    expect(travel_time).to have_key(:end_address)
    expect(travel_time[:duration]).to have_key(:text)
    expect(travel_time[:duration]).to have_key(:value)
  end
end
