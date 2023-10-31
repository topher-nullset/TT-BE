class SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.new(subscription_params.merge(user_id: params[:user_id]))

    if subscription.save
      tea = Tea.find_by(id: params[:subscription][:tea_id])
      unless tea
        render json: { errors: "Tea not found" }, status: 422
        subscription.destroy
        return
      end

      TeaSubscription.create!(subscription_id: subscription.id, tea_id: params[:subscription][:tea_id])
      render json: subscription, status: 201
    else
      render json: { errors: subscription.errors.full_messages }, status: 422
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency)
  end
end
