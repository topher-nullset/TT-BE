class Tea < ApplicationRecord
  has_and_belongs_to_many :subscriptions

  validates :title, :description, :temperature, :brew_time, presence: true
  validates :temperature, numericality: { only_integer: true, greater_than: 0 }
  validates :brew_time, numericality: { only_integer: true, greater_than: 0 }
end
