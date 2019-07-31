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
    travel_data = travel_time(origin, destination)
    weather_data = forecast_data(destination)
    road_trip = RoadTrip.new(travel_data, weather_data)
    RoadTripSerializer.new(road_trip)
  end

  private

  def forecast_data(destination)
    Rails.cache.fetch(destination, expires_in: 1.hours) do
      WeatherService.forecast_data(destination)
    end
  end

  def travel_time(origin, destination)
    Rails.cache.fetch("#{origin}/#{destination}", expires_in: 1.hours) do
      GoogleService.travel_time(origin, destination)
    end
  end
end
