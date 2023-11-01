# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# Create teas
FactoryBot.create_list(:tea, 1000)

# Create users with subscriptions
FactoryBot.create_list(:user, 100).each do |user|
  # Create subscriptions for each user
  FactoryBot.create_list(:subscription, rand(1..10), user: user).each do |subscription|
    # Add random teas to each subscription
    teas = Tea.order("RANDOM()").limit(rand(1..5))
    subscription.teas << teas
  end
end
