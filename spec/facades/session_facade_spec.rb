require 'rails_helper'

RSpec.describe SessionFacade do
  it "renders successful login response" do
    key = '124MyKey123'

    successful = SessionFacade.successful_login(key)

    expected = {
      status: 200,
      body: {
        api_key: key
      }
    }

    expect(successful).to eq(expected)
  end

  it "renders unsuccessful login response" do
    unsuccessful = SessionFacade.unsuccessful_login

    expected = {
      status: 404,
      description: 'Invalid email/password combination'
    }

    expect(unsuccessful).to eq(expected)
  end
end
