FactoryBot.define do
  factory :tea do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    temperature { rand(90..100) }
    brew_time { rand(180..300) }
  end
end
