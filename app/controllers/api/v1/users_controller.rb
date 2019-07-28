class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      render_successful(user)
    else
      render_errors(user)
    end
  end

  private

  def render_successful(user)
    render json: {
      status: 201,
      body: {
        api_key: user.api_key
      }
    }
  end

  def render_errors(user)
    render json: {
      status: 409,
      errors: user.errors.full_messages
    }, status: 409
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
