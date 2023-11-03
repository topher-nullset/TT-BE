require 'rails_helper'

RSpec.describe 'Subscriptions Update', type: :request do
  let(:user) { create(:user) }
  let(:subscription) { create(:subscription, user: user, title: 'old sub', frequency: 'monthly') }
  let(:tea1) { create(:tea) }
  let(:teasubscription) { create(:teasubscription, tea: tea1, subscription: subscription) }
  let(:tea2) { create(:tea) }

  before do
    post '/sessions', params: { email: user.email, password: user.password }
  end

  describe 'PATCH /users/:user_id/subscriptions/:id' do
    context 'with valid subscription details' do
      let(:valid_params) do
        {
          subscription: {
            title: 'Updated Subscription',
            frequency: 'bi_weekly'
          }
        }
      end

      it 'updates the subscription details' do
        patch "/users/#{user.id}/subscriptions/#{subscription.id}", params: valid_params
        expect(subscription.reload.title).to eq('Updated Subscription')
        expect(subscription.frequency).to eq('bi_weekly')
        expect(response).to have_http_status(200)
      end
    end

    context 'when adding a tea' do
      it 'adds the tea to the subscription' do
        patch "/users/#{user.id}/subscriptions/#{subscription.id}", params: { add_tea_id: tea2.id }
        expect(subscription.reload.teas).to include(tea2)
        expect(response).to have_http_status(200)
      end
    end

    context 'when removing a tea' do
      it 'removes the tea from the subscription' do
        patch "/users/#{user.id}/subscriptions/#{subscription.id}", params: { remove_tea_id: tea1.id }
        expect(subscription.reload.teas).not_to include(tea1)
        expect(response).to have_http_status(200)
      end
    end

    context 'when tea does not exist' do
      it 'returns an error' do
        patch "/users/#{user.id}/subscriptions/#{subscription.id}", params: { add_tea_id: 9999 }
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['errors']).to include("Tea not found")
      end
    end

    context 'when subscription does not exist' do
      it 'returns an error' do
        patch "/users/#{user.id}/subscriptions/#{9999}", params: { title: 'Updated Subscription' }
        expect(JSON.parse(response.body)['errors']).to include("Subscription not found")
      end
    end
  end
end
