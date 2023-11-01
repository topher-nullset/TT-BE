# README

# Tea Time Backend (TTBe)
### A Rails backend application for managing tea subscriptions.

## Features
- User registration and authentication.
- CRUD operations for tea subscriptions.
- User login sessions for tea subscriptions.


## Setup & Installation
- Make sure you have Ruby 3.2.2 installed.

<details closed>
<summary>Fork and Clone</summary>
<iframe src="https://giphy.com/embed/l1J3E1V1qv4pAc9zy" width="480" height="480" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/design-experiment-fork-l1J3E1V1qv4pAc9zy">via GIPHY</a></p>
<iframe src="https://giphy.com/embed/xTiN0pn9UrktJMnThu" width="480" height="320" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/studiosoriginals-gilphabet-xTiN0pn9UrktJMnThu">via GIPHY</a></p>
<iframe src="https://giphy.com/embed/TlK63EA6F1qRb7lll6M" width="480" height="480" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/greggunn-animation-character-mythical-TlK63EA6F1qRb7lll6M">via GIPHY</a></p>

</details>

<details closed>
<summary>Install Dependencies</summary>
- Navigate to the project root

```
$ bundle install
```
</details>

## Testing
Run tests using RSpec:
- bundle exec rspec

## Endpoints
1. Teas
  - List all teas: GET /teas (login not required)
2. Users
  - Register a user: POST /users
3. Sessions
  - Log in: POST /sessions
  - Log out: DELETE /sessions/:id  (id is user id)
4. Subscriptions (requires logged in)
  - List all subscriptions for a user: GET /users/:user_id/subscriptions
  - Create a subscription for a user: POST /users/:user_id/subscriptions
  - Update a subscription: PATCH /users/:user_id/subscriptions/:id

## Future Improvements
 Add pagination to the subscriptions list.
 Integrate with a payment gateway for subscription payments.
Add a frontend application for managing subscriptions.