class Tea < ApplicationRecord
  has_many :tea_subscriptions
  has_many :subscriptions, through: :tea_subscriptions


  validates :title, :description, :temperature, :brew_time, presence: true
  validates :temperature, numericality: { only_integer: true, greater_than: 0 }
  validates :brew_time, numericality: { only_integer: true, greater_than: 0 }
end
