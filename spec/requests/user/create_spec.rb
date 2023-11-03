require 'rails_helper'

RSpec.describe 'User Creation', type: :request do
  describe 'POST /users' do
    let(:user_params) do
      {
        first_name: 'Megan',
        last_name: 'McCarthy',
        email: 'megan@mccarthy.com',
        address: '3462 Strawberry Rd. Anchorage AK 99502',
        password: 'test123test',
        password_confirmation: 'test123test'
      }
    end

    context 'when valid parameters are provided' do
      it 'creates a user' do
        expect {
          post '/users', params: user_params
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)
        expect(json["id"]).to eq(User.last.id)
        expect(json["first_name"]).to eq(user_params[:first_name])
        expect(json["last_name"]).to eq(user_params[:last_name])
        expect(json["email"]).to eq(user_params[:email])
        expect(json["address"]).to eq(user_params[:address])
      end
    end

    context 'when invalid parameters are provided' do
      it 'does not create a user with missing email' do
        post '/users', params: user_params.except(:email)
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)

        expect(json["errors"]).to include("Email can't be blank")
        expect(json["errors"]).to include("Email must be a valid email format")
        expect(User.count).to eq(0)
      end
    end

    context 'when email is not unique' do
      it 'does not create a user with duplicate email' do
        User.create(user_params)
        post '/users', params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)

        expect(json["errors"]).to include("Email has already been taken")
        expect(User.count).to eq(1)
      end
    end
  end
end
