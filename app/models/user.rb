class User < ApplicationRecord
  has_secure_password
  has_many :subscriptions

  validates :first_name, :last_name, :email, :address, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email format" }
  validates :email, uniqueness: true
end
