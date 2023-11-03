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

## Future Improvements
- Add pagination to the subscriptions list.
- Integrate with a payment gateway for subscription payments.
- Add a frontend application for managing subscriptions.
