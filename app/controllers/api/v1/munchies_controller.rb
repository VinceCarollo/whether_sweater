class Api::V1::MunchiesController < ApplicationController
  def index
    travel_data = travel_time_service
    
  end

  private

  def travel_time_service
    start_city = params[:start]
    end_city = params[:end]
    GoogleService.travel_time(start_city, end_city)
  end
end
