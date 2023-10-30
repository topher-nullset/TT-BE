FactoryBot.define do
  factory :subscription do
    title { "MyString" }
    price { 1.5 }
    status { false }
    frequency { "MyString" }
    user { nil }
  end
end
