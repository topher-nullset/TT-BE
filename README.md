# README

# Tea Time Backend (TTBe)
#### A Rails backend application for managing tea subscriptions.

## Features
- User registration and authentication.
- CRUD operations for tea subscriptions.
- User login sessions for tea subscriptions.


## Setup & Installation
- Make sure you have Ruby 3.2.2 installed.

<details closed>
<summary>Fork and Clone</summary>
  
<img src="./storage/fork.gif" alt="Fork" width="200"/>
<img src="./storage/ampersand.gif" alt="and" width="200"/>
<img src="./storage/clone.gif" alt="clone" width="200"/>

</details>

<details closed>
<summary>Install Dependencies</summary>
- Navigate to the project root

```
$ bundle install
```
</details>

<details closed>
<summary>Build Database</summary>
  
```
$ rails db:{create,migrate,seed}

"Created 1000 teas and 100 users with 486 total subscriptions with 1465 total tea-subscriptions"
```
</details>

## Testing
Run tests using RSpec:
- bundle exec rspec

## Endpoints
1. Teas
  - List all teas
2. Users
  - Register a user
3. Sessions
  - Log in
  - Log out
4. Subscriptions (requires logged in)
  - List all subscriptions for a user
  - Create a subscription for a user
  - Update a subscription

<details closed>
<summary>Routes Format</summary>

```
               teas GET    /teas(.:format)                                               teas#index
           sessions POST   /sessions(.:format)                                           sessions#create
            session DELETE /sessions/:id(.:format)                                       sessions#destroy
 user_subscriptions GET    /users/:user_id/subscriptions(.:format)                       subscriptions#index
                    POST   /users/:user_id/subscriptions(.:format)                       subscriptions#create
  user_subscription PATCH  /users/:user_id/subscriptions/:id(.:format)                   subscriptions#update
                    PUT    /users/:user_id/subscriptions/:id(.:format)                   subscriptions#update
              users POST   /users(.:format)                                              users#create
               user PATCH  /users/:id(.:format)                                          users#update
                    PUT    /users/:id(.:format)                                          users#update
```
</details>

## Schema

<details>
<summary>Database Schema</summary>

```
ActiveRecord::Schema[7.0].define(version: 2023_10_31_194749) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "subscriptions", force: :cascade do |t|
    t.string "title"
    t.float "price"
    t.integer "status", default: 0
    t.integer "frequency", default: 0
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "tea_subscriptions", id: false, force: :cascade do |t|
    t.bigint "tea_id", null: false
    t.bigint "subscription_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tea_id", "subscription_id"], name: "index_tea_subscriptions_on_tea_id_and_subscription_id", unique: true
  end

  create_table "teas", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "temperature"
    t.integer "brew_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "subscriptions", "users"
end
```

</details>

## Future Improvements
- Add pagination to the subscriptions list.
- Integrate with a payment gateway for subscription payments.
- Add a frontend application for managing subscriptions.
