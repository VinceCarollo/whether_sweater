class Api::V1::MunchiesController < ApplicationController
  def index
    begin
      travel_data = travel_time_service
      restaurant_data = restaurant_service(travel_data)
      munchie = Munchie.new
      munchie.add_data(travel_data, restaurant_data)
      render json: { data: munchie }
    rescue NoMethodError
      render json: { status: 404, description: "Not Found"}, status: 404
    end
  end

  private

  def restaurant_service(travel_data)
    travel_time = travel_data[:routes].first[:legs].first[:duration][:value]
    hours_traveled = Time.at(travel_time).utc.hour
    minutes_traveled = Time.at(travel_time).utc.min
    time_arriving = Time.now + hours_traveled.hours + minutes_traveled.minutes
    YelpService.open_restaurants(time_arriving, params[:end], params[:food])
  end

  def travel_time_service
    start_city = params[:start]
    end_city = params[:end]
    GoogleService.travel_time(start_city, end_city)
  end
end
