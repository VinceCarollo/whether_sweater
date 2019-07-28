require 'rails_helper'

RSpec.describe WeatherService do
  it "can get forecast data from city input" do
    city = 'kansas city,mo'

    forecast_data = WeatherService.forecast_data(city)

    expect(forecast_data).to have_key(:timezone)
    expect(forecast_data[:currently]).to have_key(:time)
    expect(forecast_data[:currently]).to have_key(:summary)
    expect(forecast_data[:currently]).to have_key(:icon)
    expect(forecast_data[:currently]).to have_key(:temperature)
    expect(forecast_data[:currently]).to have_key(:humidity)
    expect(forecast_data[:currently]).to have_key(:apparentTemperature)

    hourly_data = forecast_data[:hourly][:data]

    expect(hourly_data.count).to be >= 8
    expect(hourly_data.first).to have_key(:time)
    expect(hourly_data.first).to have_key(:temperature)

    daily_data = forecast_data[:daily][:data]

    expect(daily_data.count).to be >= 5
    expect(daily_data.first).to have_key(:time)
    expect(daily_data.first).to have_key(:summary)
    expect(daily_data.first).to have_key(:humidity)
    expect(daily_data.first).to have_key(:temperatureHigh)
    expect(daily_data.first).to have_key(:temperatureLow)
  end
end
