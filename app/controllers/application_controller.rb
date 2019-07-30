class ApplicationController < ActionController::Base

  def render_not_found
    render json: { description: 'Not Found', status: 404 }, status: 404
  end
end
