require 'rails_helper'

RSpec.describe YelpService do
  it "can get open restaurants with arrival time, destination, and food type" do
    restaurant_data = YelpService.open_restaurants(Time.now, 'kansas city, mo', 'bbq')

    restaurants = restaurant_data[:businesses]

    expect(restaurants.count).to be > 3
    expect(restaurants.first).to have_key(:name)
    expect(restaurants.first[:location]).to have_key(:address1)
    expect(restaurants.first[:location]).to have_key(:city)
    expect(restaurants.first[:location]).to have_key(:zip_code)
  end
end
