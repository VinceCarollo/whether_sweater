require 'rails_helper'

RSpec.describe 'Users API' do

  it "can create users" do
    user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    post '/api/v1/users', params: user.to_json, headers: headers

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

    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    post '/api/v1/users', params: user.to_json, headers: headers

    user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    post '/api/v1/users', params: user.to_json, headers: headers

    result = JSON.parse(response.body, symbolize_names: true)

    expect(status).to eq(409)

    expect(result[:status]).to eq(409)
    expect(result[:errors].first).to eq('Email has already been taken')
  end

  it "can give errors if fields are empty" do
    user = {
      "email": "",
      "password": "password",
      "password_confirmation": "password"
    }

    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    post '/api/v1/users', params: user.to_json, headers: headers

    result = JSON.parse(response.body, symbolize_names: true)

    expect(status).to eq(409)

    expect(result[:status]).to eq(409)
    expect(result[:errors].first).to eq("Email can't be blank")
  end

  it "can give errors if passwords do not match" do
    user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "not_password"
    }

    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    post '/api/v1/users', params: user.to_json, headers: headers

    result = JSON.parse(response.body, symbolize_names: true)

    expect(status).to eq(409)

    expect(result[:status]).to eq(409)
    expect(result[:errors].first).to eq("Password confirmation doesn't match Password")
  end

  it "can log users in" do
    user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    post '/api/v1/users', params: user.to_json, headers: headers

    api_key = JSON.parse(response.body, symbolize_names: true)[:body][:api_key]

    login = {
      "email": "whatever@example.com",
      "password": "password"
    }

    post '/api/v1/sessions', params: login.to_json, headers: headers

    comfirmation = JSON.parse(response.body, symbolize_names: true)

    expect(comfirmation[:status]).to eq(200)
    expect(comfirmation[:body][:api_key]).to eq(api_key)
  end

  it "can't login with incorrect password" do
    user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    post '/api/v1/users', params: user.to_json, headers: headers

    api_key = JSON.parse(response.body, symbolize_names: true)[:body][:api_key]

    login = {
      "email": "whatever@example.com",
      "password": "not_password"
    }

    post '/api/v1/sessions', params: login.to_json, headers: headers

    error = JSON.parse(response.body, symbolize_names: true)

    expected = {
      status: 404,
      description: 'Invalid email/password combination'
    }

    expect(error).to eq(expected)
  end

end
