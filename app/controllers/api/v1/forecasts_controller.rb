class Api::V1::ForecastsController < ApplicationController
  def index
    begin
      render json: ForecastFacade.forecast(params)
    rescue NoMethodError
      render_not_found
    end
  end
end
