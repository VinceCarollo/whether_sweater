class Api::V1::BackgroundsController < ApplicationController
  def index
    query = params[:location].split(',').first
    response = Faraday.get('https://api.unsplash.com/search/photos') do |req|
      req.params[:query] = query
      req.params[:client_id] = ENV['UNSPLASH_API_KEY']
    end
    images_data = JSON.parse(response.body, symbolize_names: true)
    images = Array.new
    images_data[:results][0..9].each do |image_data|
      images << {
        url: image_data[:urls][:full],
        alt_description: image_data[:alt_description]
      }
    end
    render json: { data: images }
  end
end
