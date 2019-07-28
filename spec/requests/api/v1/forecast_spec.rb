require 'rails_helper'

RSpec.describe "Forecast API" do
  context 'main section' do

    it "returns main city info from given city" do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      main = JSON.parse(response.body, symbolize_names: true)[:data][:main]

      expect(main).to have_key(:location)
      expect(main[:location]).to eq('denver, co')
      expect(main).to have_key(:summary)
      expect(main).to have_key(:temperature)
      expect(main).to have_key(:high)
      expect(main).to have_key(:low)
      expect(main).to have_key(:country)
      expect(main).to have_key(:time)
      expect(main).to have_key(:date)
      expect(main).to have_key(:icon)
    end

    it "returns main city info from different given city" do
      get '/api/v1/forecast?location=kansas city,mo'

      expect(response).to be_successful

      main = JSON.parse(response.body, symbolize_names: true)[:data][:main]

      expect(main).to have_key(:location)
      expect(main[:location]).to eq('kansas city, mo')
      expect(main).to have_key(:summary)
      expect(main).to have_key(:temperature)
      expect(main).to have_key(:high)
      expect(main).to have_key(:low)
      expect(main).to have_key(:country)
      expect(main).to have_key(:time)
      expect(main).to have_key(:date)
      expect(main).to have_key(:icon)
    end

    it "returns 404 if invalid city" do
      get '/api/v1/forecast?location=invalid'

      expect(status).to eq(404)
    end
  end

  context 'details section' do
    it "returns details from given city" do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      details = JSON.parse(response.body, symbolize_names: true)[:data][:details]

      expect(details).to have_key(:summary)
      expect(details).to have_key(:icon)
      expect(details).to have_key(:today)
      expect(details).to have_key(:tonight)
      expect(details).to have_key(:feels_like)
      expect(details).to have_key(:humidity)
      expect(details).to have_key(:visibility)
      expect(details).to have_key(:uv_index)
    end
  end

  context 'extended forecast section' do
    it "returns extended forecast from given city" do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      extended_forecast = JSON.parse(response.body, symbolize_names: true)[:data][:extended_forecast]

      expect(extended_forecast[:hourly].length).to eq(8)
      expect(extended_forecast[:daily].length).to eq(5)

      expect(extended_forecast[:hourly].first).to have_key(:time)
      expect(extended_forecast[:hourly].first).to have_key(:temperature)

      expect(extended_forecast[:daily].first).to have_key(:week_day)
      expect(extended_forecast[:daily].first).to have_key(:summary)
      expect(extended_forecast[:daily].first).to have_key(:icon)
      expect(extended_forecast[:daily].first).to have_key(:precip)
      expect(extended_forecast[:daily].first).to have_key(:high)
      expect(extended_forecast[:daily].first).to have_key(:low)
    end
  end
end
