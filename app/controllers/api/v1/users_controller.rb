class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    response = {}
    user = User.new(user_params)
    if user.save
      render json: {
        status: 201,
        body: {
          api_key: user.api_key
        }
      }
    else
      render json: {
        status: 409,
        errors: user.errors.full_messages
      }, status: 409
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
