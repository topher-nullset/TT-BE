Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :teas, only: [:index]
  resources :sessions, only: [:create, :destroy]
  resources :users, only: [:create, :update] do
    resources :subscriptions, only: [:index, :create, :update]
  end
end
