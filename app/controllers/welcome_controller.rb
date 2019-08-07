class WelcomeController < ApplicationController
  def show
    render json: { message: 'Welcome to the root of whether sweater' }
  end
end
