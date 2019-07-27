class Api::V1::ForecastsController < ApplicationController
  def index
    begin
      location = params[:location]
      city_weather = city_weather(location)
      render json: city_weather
    rescue NoMethodError
      raise ActionController::RoutingError.new('City is Invalid')
    end
  end

  private

  def city_weather(location)
    forecast_data = WeatherService.forecast_data(location)
    forecast = Forecast.new(forecast_data, location)
    forecast.add_main_data
    ForecastSerializer.new(forecast).serializable_hash
  end
end
