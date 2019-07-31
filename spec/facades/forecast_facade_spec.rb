require 'rails_helper'

RSpec.describe ForecastFacade do
  it "can return forecast data", :vcr do
    params = { location: 'kansas city,mo' }

    forecast = ForecastFacade.forecast(params)

    expect(forecast).to be_a ForecastSerializer
  end
end
