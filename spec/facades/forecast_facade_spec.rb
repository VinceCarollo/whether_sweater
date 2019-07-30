require 'rails_helper'

RSpec.describe ForecastFacade do
  it "can return forecast data", :vcr do
    params = { location: 'kansas city,mo' }

    forecast = ForecastFacade.forecast_data(params)

    expect(forecast).to have_key(:data)
    expect(forecast[:data]).to be_a Forecast
  end
end
