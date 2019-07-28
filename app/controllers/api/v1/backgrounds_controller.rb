class Api::V1::BackgroundsController < ApplicationController
  def index
    response = Faraday.get('https://api.unsplash.com/search/photos?query=denver&client_id=dd3e9a5e6d4d4e3c910754795ec90924d032421cf988c97280e021e4fe49f0b1')
  end
end
