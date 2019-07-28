class ErrorsController < ApplicationController
  def routing
     error = {
      status: "Not Found",
      message: "No route matches '#{request.method} #{request.path}'",
      code: "404"
      }
    render json: error, status: 404
  end
end
