class Api::V1::ForecastsController < ApplicationController
  def index
    response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |req|
      req.params[:address] = params[:location]
      req.params[:key] = ENV['GOOGLE_API_KEY']
    end
    location_data = JSON.parse(response.body, symbolize_names: true)
    lat = location_data[:results].first[:geometry][:location][:lat]
    lng = location_data[:results].first[:geometry][:location][:lng]
    response = Faraday.get("https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/#{lat},#{lng}")
    binding.pry
  end
end
