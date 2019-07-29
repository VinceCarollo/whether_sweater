class Api::V1::MunchiesController < ApplicationController
  def index
    begin
      render json: MunchiesFacade.munchie_data(params)
    rescue NoMethodError
      render json: { status: 404, description: "Not Found"}, status: 404
    end
  end
end
