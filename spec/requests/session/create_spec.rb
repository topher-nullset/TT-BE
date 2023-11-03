require 'rails_helper'

RSpec.describe "User Sessions", type: :request do
  let(:user) { create(:user, password: 'securepassword', password_confirmation: 'securepassword') }

  describe "POST /sessions" do
    # Sad paths for login
    context "when invalid credentials are provided" do
      it "returns an error when the email is invalid" do
        post '/sessions', params: { email: 'invalid@example.com', password: 'securepassword' }
        expect(response).to have_http_status(:unauthorized)

        json = JSON.parse(response.body)
        expect(json['error']).to eq("Invalid email/password combination")
      end

      it "returns an error when the password is incorrect" do
        post '/sessions', params: { email: user.email, password: 'wrongpassword' }
        expect(response).to have_http_status(:unauthorized)

        json = JSON.parse(response.body)
        expect(json['error']).to eq("Invalid email/password combination")
      end

      it 'does not allow a user to sign in multiple times' do
        post sessions_path, params: { email: user.email, password: user.password }
        expect(response).to have_http_status(:ok)

        post sessions_path, params: { email: user.email, password: user.password }
        expect(response).to have_http_status(:forbidden)
        
        json = JSON.parse(response.body)
        expect(json['error']).to eq('User already logged in')
      end
    end

    # Happy path for login
    context "when valid credentials are provided" do
      it "logs the user in and returns a success status" do
        post '/sessions', params: { email: user.email, password: 'securepassword' }
        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)
        expect(json['status']).to eq('logged in')
        expect(json['user_id']).to eq(user.id)
      end
    end
  end
end
