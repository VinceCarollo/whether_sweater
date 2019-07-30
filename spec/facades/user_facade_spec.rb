require 'rails_helper'

RSpec.describe UserFacade do
  it "can give user created json" do
    key = '1234KEY'

    expected = {
      status: 201,
      body: {
        api_key: key
      }
    }

    successful_return = UserFacade.user_created(key)

    expect(successful_return).to eq(expected)
  end

  it "can give user not created json" do
    errors = ["Email has been taken", "Password can't be blank"]

    expected = {
      status: 409,
      errors: errors
    }

    unsuccessful_return = UserFacade.user_not_created(errors)

    expect(unsuccessful_return).to eq(expected)
  end


end
