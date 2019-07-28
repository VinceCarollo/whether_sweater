class Api::V1::BackgroundsController < ApplicationController
  def index
    city = params[:location].split(',').first
    images_data = ImageService.backgrounds(city)
    images = create_images(images_data)
    render_images(images)
  end

  private

  def render_images(images)
    if images.empty?
      render json: { description: 'City Not Found', status: 404 }, status: 404
    else
      render json: { data: images }
    end
  end

  def create_images(images_data)
    images_data[:results][0..9].map do |image_data|
      {
        url: image_data[:urls][:full],
        alt_description: image_data[:alt_description]
      }
    end
  end
end
