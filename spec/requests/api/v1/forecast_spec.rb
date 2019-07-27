require 'rails_helper'

RSpec.describe "Forecast API" do
  context 'main section' do

    it "returns main city info from given city" do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      main = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:city_weather][:main]

      expect(main).to have_key(:city)
      expect(main[:city]).to eq('denver, co')
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

      main = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:city_weather][:main]

      expect(main).to have_key(:city)
      expect(main[:city]).to eq('kansas city, mo')
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

      expect(response).to_not be_successful
      expect(status).to eq(404)
    end
  end

  context 'details section' do
    it "returns details from given city" do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      details = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:city_weather][:details]

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

      extended_forecast = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:city_weather][:extended_forecast]

    end
  end
end
