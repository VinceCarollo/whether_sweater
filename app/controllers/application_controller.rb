class ApplicationController < ActionController::Base
  def render_not_found
    render json: { description: 'Not Found', status: 404 }, status: 404
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
