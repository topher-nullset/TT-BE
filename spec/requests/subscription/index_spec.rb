RSpec.describe 'Subscriptions Index', type: :request do
  let(:user) { create(:user) }
  let!(:teas) { create_list(:tea, 6) }
  let!(:subscriptions) do
    [
      create(:subscription, user: user, teas: [teas[0]]),
      create(:subscription, user: user, teas: [teas[1], teas[2]]),
      create(:subscription, user: user, teas: [teas[3], teas[4], teas[5]])
    ]
  end
  let!(:other_user_subscription) { create(:subscription) }

  before do
    post '/sessions', params: { email: user.email, password: user.password }
  end

  describe 'GET /users/:user_id/subscriptions' do
    context 'when retrieving a user\'s subscriptions' do
      before { get "/users/#{user.id}/subscriptions" }

      it 'returns all the user\'s subscriptions' do
        expect(response).to have_http_status(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.size).to eq(3)

        expect(parsed_response[0]['id']).to eq(subscriptions[0].id)
        expect(parsed_response[0]['teas'][0]['id']).to eq(teas[0].id)

        expect(parsed_response[1]['id']).to eq(subscriptions[1].id)
        expect(parsed_response[1]['teas'][0]['id']).to eq(teas[1].id)
        expect(parsed_response[1]['teas'][1]['id']).to eq(teas[2].id)

        expect(parsed_response[2]['id']).to eq(subscriptions[2].id)
        expect(parsed_response[2]['teas'][0]['id']).to eq(teas[3].id)
        expect(parsed_response[2]['teas'][1]['id']).to eq(teas[4].id)
        expect(parsed_response[2]['teas'][2]['id']).to eq(teas[5].id)
      end

      it 'does not return other users\' subscriptions' do
        parsed_response = JSON.parse(response.body)
        subscription_ids = parsed_response.map { |sub| sub["id"] }
        expect(subscription_ids).not_to include(other_user_subscription.id)
      end
    end

    context 'when user does not exist' do
      it 'returns an error' do
        get "/users/9999/subscriptions"
        expect(response).to have_http_status(422)

        json = JSON.parse(response.body)
        expect(json['errors']).to include('User not found')
      end
    end
  end
end
