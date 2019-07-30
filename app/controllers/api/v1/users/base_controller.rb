class Api::V1::Users::BaseController < ApplicationController
  before_action :require_user

  def require_user
    render_no_auth unless current_user
  end

  def current_user
    @current_user ||= User.find_by(api_key: params[:api_key]) if params[:api_key]
  end

  def render_no_auth
    render json: { description: 'Not Authorized', status: 401 }, status: 401
  end
end
