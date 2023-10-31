require 'rails_helper'

RSpec.describe 'Subscriptions Update', type: :request do
  let(:user) { create(:user) }
  let(:subscription) { create(:subscription, user: user, title: 'old sub', frequency: 'monthly') }
  let(:tea1) { create(:tea) }
  let(:teasubscription) { create(:teasubscription, tea: tea1, subscription: subscription) }
  let(:tea2) { create(:tea) }

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
        expect {
          patch "/users/#{user.id}/subscriptions/#{subscription.id}", params: { add_tea_id: 9999 } # assuming 9999 doesn't exist
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    # Additional error handling tests, such as validation errors, can go here.

  end
end
