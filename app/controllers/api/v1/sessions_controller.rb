class Api::V1::SessionsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: SessionFacade.successful_login(user.api_key)
    else
      render json: SessionFacade.unsuccessful_login
    end
  end
end
