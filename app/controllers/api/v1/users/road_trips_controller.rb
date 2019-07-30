class Api::V1::Users::RoadTripsController < Api::V1::Users::BaseController
  protect_from_forgery with: :null_session
  
  def index
    origin = params[:origin]
    destination = params[:destination]
    travel_data = GoogleService.travel_time(origin, destination)
    weather_data = WeatherService.forecast_data(destination)
    road_trip = RoadTrip.new(travel_data, weather_data)
    render json: RoadTripSerializer.new(road_trip)
  end
end
