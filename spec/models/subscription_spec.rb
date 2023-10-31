require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:frequency) }
    it { should validate_presence_of(:user) }

    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

    it { should define_enum_for(:status) }
    it { should define_enum_for(:frequency) }
  end

  describe "associations" do
    it { should have_many(:tea_subscriptions) }
    it { should have_many(:teas).through(:tea_subscriptions) }
    it { should belong_to(:user)}
  end
end
