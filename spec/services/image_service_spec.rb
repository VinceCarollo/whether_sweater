require 'rails_helper'

RSpec.describe ImageService do
  it "can get backgrounds by city", :vcr do
    city = 'kansas city,mo'

    images_data = ImageService.backgrounds(city)
    expect(images_data[:results].count).to eq(10)
    expect(images_data[:results].first[:urls]).to have_key(:full)
    expect(images_data[:results].first).to have_key(:alt_description)
  end
end
