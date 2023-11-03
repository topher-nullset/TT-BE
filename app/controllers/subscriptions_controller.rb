class SubscriptionsController < ApplicationController
  before_action :require_logged_in
  before_action :set_subscription, only: [:update]

  def index
    user = User.find_by(id: params[:user_id])

    unless user
      render_errors(nil, ["User not found"])
      return
    end

    subscriptions = user.subscriptions.includes(:teas)
    render json: subscriptions.as_json(include: :teas), status: 200
  end

  def create
    subscription = Subscription.new(subscription_params.merge(user_id: params[:user_id]))

    if subscription.save && add_tea_to_subscription(subscription, params[:subscription][:tea_id])
      render json: subscription, status: 201
    else
      subscription.destroy if subscription.persisted?
      render_errors(subscription)
    end
  end

  def update
    update_subscription_details if params[:subscription].present?

    add_tea_to_subscription(@subscription, params[:add_tea_id]) if params[:add_tea_id]
    remove_tea_from_subscription(params[:remove_tea_id]) if params[:remove_tea_id]

    if @subscription.errors.empty? && @subscription.save
      render json: @subscription, status: 200
    else
      render_errors(@subscription)
    end
  end

  private

  def render_errors(resource, custom_errors = [])
    errors = resource&.errors&.full_messages || []
    errors.concat(custom_errors)
    render json: { errors: errors }, status: 422
  end

  def set_subscription
    @subscription = Subscription.find_by(id: params[:id])
    render_errors(nil, ["Subscription not found"]) unless @subscription
  end

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency)
  end

  def update_subscription_details
    @subscription.update(subscription_params)
  end

  def add_tea_to_subscription(subscription, tea_id)
    tea = Tea.find_by(id: tea_id)
    unless tea
      subscription.errors.add(:tea, "not found")
      return false
    end

    subscription.teas << tea unless subscription.teas.include?(tea)
    true
  end

  def remove_tea_from_subscription(tea_id)
    tea = Tea.find_by(id: tea_id)
    @subscription.teas.delete(tea) if tea
  end
end
