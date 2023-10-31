require 'rails_helper'

RSpec.describe "User Sessions", type: :request do
  let(:user) { create(:user, password: 'securepassword', password_confirmation: 'securepassword') }

  describe "DELETE /sessions/:id" do
    # Sad paths for logout
    context "when the user is not logged in" do
      it "returns an error" do
        delete "/sessions/1" # The ID doesn't matter here since no user is logged in
        expect(response).to have_http_status(:unauthorized)

        json = JSON.parse(response.body)
        expect(json['error']).to eq("No user is currently logged in")
      end
    end

    # Happy path for logout
    context "when a user is logged in" do
      before do
        post '/sessions', params: { email: user.email, password: 'securepassword' }
      end

      it "logs the user out and returns a success status" do
        delete "/sessions/#{user.id}"
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json['status']).to eq('logged out')
      end
    end
  end
end
