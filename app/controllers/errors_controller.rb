class ErrorsController < ApplicationController
  def routing
     error = {
      status: "error",
      message: "No route matches '#{request.method} #{request.path}'",
      code: "400"
      }
    render json: error, status: 400
  end
end
