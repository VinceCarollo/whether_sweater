require 'rails_helper'

RSpec.describe 'Users API' do

  it "can create users" do
    user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    post '/api/v1/users', params: user.to_json, headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}

    expect(response).to be_successful

    user = User.last

    expect(user.email).to eq(user['email'])

    user_status = JSON.parse(response.body, symbolize_names: true)

    expect(user_status[:body]).to have_key(:api_key)
  end

  it "can give errors if email is taken" do
    user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    post '/api/v1/users', params: user.to_json, headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}

    user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    post '/api/v1/users', params: user.to_json, headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}

    result = JSON.parse(response.body, symbolize_names: true)

    expect(status).to eq(409)

    expect(result[:status]).to eq(409)
    expect(result[:errors].first).to eq('Email has already been taken')
  end

end
