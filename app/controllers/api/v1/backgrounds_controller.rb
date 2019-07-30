class Api::V1::BackgroundsController < ApplicationController
  def index
    begin
      render json: BackgroundFacade.background_data(params)
    rescue NoMethodError
      render_not_found
    end
  end
end
