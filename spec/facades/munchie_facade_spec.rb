require 'rails_helper'

RSpec.describe MunchieFacade do
  it "can get munchie data" do
    params = {
      start: 'denver, co',
      end: 'new york, ny',
      food: 'chinese'
    }

    munchie = MunchieFacade.munchie_data(params)

    expect(munchie).to have_key(:data)
    expect(munchie[:data]).to be_a Munchie
  end
end
