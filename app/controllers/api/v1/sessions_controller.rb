class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      render json: {
        status: 200,
        body: {
          api_key: user.api_key
        }
      }
    else
      render json: {
        status: 404,
        description: 'Invalid email/password combination'
      }
    end
  end
end
