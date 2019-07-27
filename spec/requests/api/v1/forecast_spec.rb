require 'rails_helper'

RSpec.describe "Forecast API" do
  context 'main section' do

    it "returns main city info from given city" do
      get '/api/v1/forecast?location=denver,co'
      binding.pry
      main_data = JSON.parse(response.body, symbolize_names: true)[:main]

      expect(main_data).to have_key(:city)
      expect(main_data[:city]).to eq('denver, co')
      expect(main_data).to have_key(:summary)
      expect(main_data).to have_key(:temperature)
      expect(main_data).to have_key(:high)
      expect(main_data).to have_key(:low)
      expect(main_data).to have_key(:country)
      expect(main_data).to have_key(:time)
      expect(main_data).to have_key(:date)
      expect(main_data).to have_key(:icon)
    end
  end
end