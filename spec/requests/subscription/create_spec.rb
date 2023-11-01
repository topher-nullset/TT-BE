require 'rails_helper'

RSpec.describe 'Subscriptions Creation', type: :request do
  let(:user) { create(:user) }
  let(:tea) { create(:tea) }

  before do
    post '/sessions', params: { email: user.email, password: user.password }
  end

  describe 'POST /users/:user_id/subscriptions' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          subscription: {
            title: 'Premium Subscription',
            price: 15.99,
            status: 'active',
            frequency: 'monthly',
            tea_id: tea.id
          }
        }
      end

      it 'creates a new subscription for the user and associates the tea' do
        expect {
          post "/users/#{user.id}/subscriptions", params: valid_params
        }.to change{ Subscription.count }.by(1)
          .and change{ TeaSubscription.count }.by(1)

        expect(response).to have_http_status(201)
        json = JSON.parse(response.body)
        subscription = Subscription.last

        expect(json['id']).to eq(subscription.id)
        expect(json['title']).to eq(valid_params[:subscription][:title])
        expect(json['price']).to eq(valid_params[:subscription][:price])
        expect(json['status']).to eq(valid_params[:subscription][:status])
        expect(json['frequency']).to eq(valid_params[:subscription][:frequency])
        expect(json['user_id']).to eq(user.id)

        expect(subscription.teas).to include(tea)
      end
    end

    context 'with invalid subscription parameters' do
      let(:invalid_params) do
        {
          subscription: {
            title: '',
            price: 15.99,
            status: 'active',
            frequency: 'monthly',
            tea_id: tea.id
          }
        }
      end

      it 'does not create a new subscription' do
        expect {
          post "/users/#{user.id}/subscriptions", params: invalid_params
        }.not_to change(Subscription, :count)
        expect(JSON.parse(response.body)['errors']).to include("Title can't be blank")
      end

      it 'returns a 422 status code' do
        post "/users/#{user.id}/subscriptions", params: invalid_params
        expect(response).to have_http_status(422)
      end
    end

    context 'when tea_id is missing' do
      let(:params_without_tea) do
        {
          subscription: {
            title: 'Premium Subscription',
            price: 15.99,
            status: 'active',
            frequency: 'monthly'
          }
        }
      end

      it 'does not create a new subscription' do
        expect {
          post "/users/#{user.id}/subscriptions", params: params_without_tea
        }.not_to change(Subscription, :count)
      end

      it 'does not create a tea_subscription' do
        expect {
          post "/users/#{user.id}/subscriptions", params: params_without_tea
        }.not_to change(TeaSubscription, :count)
      end

      it 'returns a 422 status code' do
        post "/users/#{user.id}/subscriptions", params: params_without_tea
        expect(response).to have_http_status(422)
      end
    end

    context 'when user isn\'t logged in' do
      let(:params) do
        {
          subscription: {
            title: 'Premium Subscription',
            price: 15.99,
            status: 'active',
            frequency: 'monthly',
            tea_id: tea.id
          }
        }
      end

      it 'returns an error message' do
        delete "/sessions/#{user.id}" # logout user
        post "/users/#{user.id}/subscriptions", params: params

        expect(response).to have_http_status(401)
        expect(JSON.parse(response.body)['error']).to eq("You must be logged in to access this section")
      end
    end
  end
end
