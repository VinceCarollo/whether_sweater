class Api::V1::ForecastsController < ApplicationController
  def index
    begin
      location = params[:location]
      forecast_data = WeatherService.forecast_data(location)
      forecast = Forecast.new(forecast_data, location)
      forecast.add_main_data
      weather_for_city = ForecastSerializer.new(forecast).serializable_hash
      render json: weather_for_city
    rescue NoMethodError
      raise ActionController::RoutingError.new('City is Invalid')
    end
  end
end
