class Api::V1::MunchiesController < ApplicationController
  def index
    begin
      render json: MunchieFacade.munchie(params)
    rescue NoMethodError
      render_not_found
    end
  end
end
