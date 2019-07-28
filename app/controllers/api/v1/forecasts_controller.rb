class Api::V1::ForecastsController < ApplicationController
  def index
    begin
      location = params[:location]
      city_weather = city_weather(location)
      render json: city_weather
    rescue
      render json: { description: 'City Not Found', status: 404 }, status: 404
    end
  end

  private

  def city_weather(location)
    forecast_data = WeatherService.forecast_data(location)
    forecast = Forecast.new(forecast_data, location)
    forecast.add_data
    ForecastSerializer.new(forecast).serializable_hash
  end
end
