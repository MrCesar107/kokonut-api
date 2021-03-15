# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/v1/users', type: :request do
  let(:password) { FFaker::Internet.password }
  let(:user_data) do
    { name: FFaker::NameMX.first_name, nickname: FFaker::NameMX.name,
      email: FFaker::Internet.email, password: password,
      password_confirmation: password }
  end

  context 'when user data is not valid' do
    it 'returns error with missing name' do
      user_data[:name] = nil
      post '/v1/users', headers: headers, params: { user: user_data }
      error = JSON.parse response.body

      expect(error['message']).to eq "Name can't be blank"
    end

    it 'returns error with missing nickname' do
      user_data[:nickname] = nil
      post '/v1/users', headers: headers, params: { user: user_data }
      error = JSON.parse response.body

      expect(error['message']).to eq "Nickname can't be blank"
    end

    it 'returns error with missing email' do
      user_data[:email] = nil
      post '/v1/users', headers: headers, params: { user: user_data }
      error = JSON.parse response.body

      expect(error['message']).to eq "Email can't be blank"
    end

    it 'returns error with missing nickname' do
      user_data[:password] = nil
      post '/v1/users', headers: headers, params: { user: user_data }
      error = JSON.parse response.body

      expect(error['message']).to eq "Password can't be blank"
    end

    it 'returns error with missing nickname' do
      user_data[:password_confirmation] = nil
      post '/v1/users', headers: headers, params: { user: user_data }
      error = JSON.parse response.body

      expect(error['message']).to eq "Password confirmation can't be blank"
    end
  end

  context 'when user data is not unique' do
    it 'returns error whit not unique email' do
      create(:user, email: user_data[:email])
      post '/v1/users', headers: headers, params: { user: user_data }
      error = JSON.parse response.body

      expect(error['message']).to eq 'Email has already been taken'
    end
  end

  context 'when user data is valid' do
    it 'creates a new user and return it as a JSON' do
      post '/v1/users', headers: headers, params: { user: user_data }
      expect(response.status).to eq 200
    end
  end

  context 'when user data is updated' do
    let(:subject) { create(:user) }
    it 'updates user data and return it as a JSON' do
      put "/v1/users/#{subject.id}/", headers: headers_with_auth_user(subject),
                                      params: { user: { nickname: 'Otro' } }
      api_response = JSON.parse response.body

      expect(api_response['nickname']).to eq 'Otro'
    end
  end
end
