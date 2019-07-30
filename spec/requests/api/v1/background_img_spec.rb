require 'rails_helper'

RSpec.describe "Background API" do
  it "gets a background image based on location input", :vcr do

    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    backgrounds = JSON.parse(response.body, symbolize_names: true)

    expect(backgrounds[:data]).to be_a Array
    expect(backgrounds[:data].count).to eq(10)
    expect(backgrounds[:data].first).to have_key(:url)
  end

  it "gets a background image based on different location input", :vcr do

    get '/api/v1/backgrounds?location=kansas city,mo'

    expect(response).to be_successful

    backgrounds = JSON.parse(response.body, symbolize_names: true)

    expect(backgrounds[:data]).to be_a Array
    expect(backgrounds[:data].count).to eq(10)
    expect(backgrounds[:data].first).to have_key(:url)
  end

  it "determines no search results", :vcr do

    get '/api/v1/backgrounds?location=invlid_input'

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:data]).to eq('No Images Found')
  end
end
