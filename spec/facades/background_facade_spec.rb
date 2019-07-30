require 'rails_helper'

RSpec.describe BackgroundFacade do

  it "can give background data", :vcr do
    params = {location: 'kansas city,mo'}

    backgrounds = BackgroundFacade.background_data(params)[:data]

    expect(backgrounds.count).to eq(10)
    expect(backgrounds.first).to have_key(:url)
    expect(backgrounds.first).to have_key(:alt_description)
  end
end
