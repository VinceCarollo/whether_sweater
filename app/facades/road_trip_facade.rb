class RoadTripFacade
  def initialize(params)
    @params = params
  end

  def self.trip(params)
    new(params).trip_data
  end

  def trip_data
    origin = @params[:origin]
    destination = @params[:destination]
    travel_data = GoogleService.travel_time(origin, destination)
    weather_data = WeatherService.forecast_data(destination)
    road_trip = RoadTrip.new(travel_data, weather_data)
    RoadTripSerializer.new(road_trip)
  end
end
