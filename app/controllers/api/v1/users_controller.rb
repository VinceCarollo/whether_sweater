class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      render json: UserFacade.user_created(user.api_key)
    else
      render json: UserFacade.user_not_created(user.errors.full_messages), status: 409
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
