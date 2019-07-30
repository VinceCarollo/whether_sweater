class Api::V1::Users::RoadTripsController < Api::V1::Users::BaseController
  protect_from_forgery with: :null_session

  def index
    render json: RoadTripFacade.trip(params)
  end
end
