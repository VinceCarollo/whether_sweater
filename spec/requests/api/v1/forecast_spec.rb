require 'rails_helper'

RSpec.describe "Forecast API" do
  context 'main section' do

    it "returns main city info from given city" do
      get '/api/v1/forecast?location=denver,co'

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
      expect{ get '/api/v1/forecast?location=invalid' }.to raise_error(ActionController::RoutingError)
    end
  end

  context 'details section' do
    it "returns details from given city" do
      get '/api/v1/forecast?location=denver,co'

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

    end
  end
end
