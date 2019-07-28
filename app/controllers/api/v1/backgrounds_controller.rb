class Api::V1::BackgroundsController < ApplicationController
  def index
    city = params[:location].split(',').first
    images_data = ImageService.backgrounds(city)
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
