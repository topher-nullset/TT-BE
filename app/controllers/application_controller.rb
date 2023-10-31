class ApplicationController < ActionController::API
  before_action :set_current_user

  private

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!@current_user
  end

  def require_logged_in
    unless logged_in?
      render json: { error: 'You must be logged in to access this section' }, status: 401
    end
  end
end
