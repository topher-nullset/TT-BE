class Subscription < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :teas

  validates :title, :price, :status, :frequency, :user, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  enum status: { active: 0, cancelled: 1, paused: 2, expired: 3 }
  enum frequency: { weekly: 0, bi_weekly: 1, monthly: 2, quarterly: 3 }
end
