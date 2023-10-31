class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])  # assuming you're using has_secure_password
      session[:user_id] = user.id
      render json: { status: 'logged in', user_id: user.id }, status: 200
    else
      render json: { error: 'Invalid email/password combination' }, status: 401
    end
  end

  def destroy
    unless session[:user_id]
      render json: { error: 'No user is currently logged in' }, status: :unauthorized
      return
    end

    session.delete(:user_id)
    @current_user = nil
    render json: { status: 'logged out' }, status: 200
  end
end
