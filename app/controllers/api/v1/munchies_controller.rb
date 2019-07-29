class Api::V1::MunchiesController < ApplicationController
  def index
    travel_data = travel_time_service
    response = Faraday.get('https://api.yelp.com/v3/businesses/search') do |req|
      req.headers['Authorization'] = 'Bearer mX5uLjmCuUsm-nG3bCKU2bmNFN_fca-qLTju6LRSXgCQmFqfBZDF3IROzkpv_r4ID5RcoCFrjE4CEC_TVJIEpMXrzYMLUJ8J-ipFm5EffcQTm_YH_Rlg2_fptRY_XXYx'
      req.params['location'] = params[:end]
      req.params['term'] = params[:food]
    end
    binding.pry
  end

  private

  def travel_time_service
    start_city = params[:start]
    end_city = params[:end]
    GoogleService.travel_time(start_city, end_city)
  end
end
