require 'rails_helper'

RSpec.describe MunchieFacade do
  it "can get munchie data" do
    params = {
      start: 'denver, co',
      end: 'new york, ny',
      food: 'chinese'
    }

    munchie = MunchieFacade.munchie(params)

    expect(munchie).to be_a MunchieSerializer
  end
end
