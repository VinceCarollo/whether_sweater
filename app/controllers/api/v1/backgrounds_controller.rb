class Api::V1::BackgroundsController < ApplicationController
  def index
    begin
      render json: BackgroundFacade.backgrounds(params)
    rescue NoMethodError
      render_not_found
    end
  end
end
