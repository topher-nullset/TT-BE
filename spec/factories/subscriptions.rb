FactoryBot.define do
  factory :subscription do
    title { Faker::Lorem.word }
    price { (rand(1099..4099) / 100.0).round(2) }
    status { rand(0..3) }
    frequency { rand(0..3) }
    association :user, factory: :user
  end
end
