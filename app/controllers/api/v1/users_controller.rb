class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    response = {}
    user = User.new(user_params)
    if user.save
      response = {
        status: 201,
        body: {
          api_key: user.api_key
        }
      }
    else
      response = {
        errors: user.errors
      }
    end
    render json: response
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
