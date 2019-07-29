class Api::V1::MunchiesController < ApplicationController
  def index
    travel_data = travel_time_service
    travel_time = travel_data[:routes].first[:legs].first[:duration][:value]
    hours_traveled = Time.at(travel_time).utc.hour
    minutes_traveled = Time.at(travel_time).utc.min
    time_arrived = Time.now + hours_traveled.hours + minutes_traveled.minutes
    response = Faraday.get('https://api.yelp.com/v3/businesses/search') do |req|
      req.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
      req.params['location'] = params[:end]
      req.params['term'] = params[:food]
      req.params['open_at'] = time_arrived.to_i
    end
    restaurant_data = JSON.parse(response.body, symbolize_names: true)
    munchie = Munchie.new
    munchie.add_travel_data(travel_data)
    munchie.add_restaurant_data(restaurant_data)
  end

  private

  def travel_time_service
    start_city = params[:start]
    end_city = params[:end]
    GoogleService.travel_time(start_city, end_city)
  end
end
