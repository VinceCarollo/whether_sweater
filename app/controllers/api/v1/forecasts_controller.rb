class Api::V1::ForecastsController < ApplicationController
  def index
    begin
      location = params[:location]
      city_weather = city_weather(location)
      render json: city_weather
    rescue
      render :file => 'public/404.html', :status => :not_found, :layout => false
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
