require 'rails_helper'

RSpec.describe "Background API" do
  it "gets a background image based on location input" do

    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    backgrounds = JSON.parse(response.body, symbolize_names: true)

    expect(backgrounds[:images]).to be_a Array
    expect(backgrounds[:images].count).to be > 1
    expect(backgrounds[:images].first).to have_key(:url)
  end
end
