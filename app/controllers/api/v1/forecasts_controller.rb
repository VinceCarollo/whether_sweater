class Api::V1::ForecastsController < ApplicationController
  def index
    location = params[:location]
    response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |req|
      req.params[:address] = location
      req.params[:key] = ENV['GOOGLE_API_KEY']
    end
    location_data = JSON.parse(response.body, symbolize_names: true)
    lat = location_data[:results].first[:geometry][:location][:lat]
    lng = location_data[:results].first[:geometry][:location][:lng]
    response = Faraday.get("https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/#{lat},#{lng}")
    forecast_data = JSON.parse(response.body, symbolize_names: true)
    forecast = Forecast.new(forecast_data, location)
    forecast.add_main_data
    weather_for_city = ForecastSerializer.new(forecast).serializable_hash
    render json: weather_for_city
  end
end
