class Api::V1::Users::RoadTripsController < Api::V1::Users::BaseController
  protect_from_forgery with: :null_session

  def index
    begin
      render json: RoadTripFacade.trip(params)
    rescue NoMethodError
      render_not_found
    end
  end
end
