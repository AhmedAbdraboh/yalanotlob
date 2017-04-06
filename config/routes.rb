Rails.application.routes.draw do
<<<<<<< HEAD
    devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  get 'auth/:provider/callback', to: 'sessions#create'

  post 'addFriend', to: "users#addFriend"
  get 'search', to: "users#index_friends"
  get 'acceptFriend/:id', to: "users#accept_friends"
  get 'declineFriend/:id', to: "users#decline_friends"
  get 'removeFriend/:id', to: "users#remove_friends"


  resources :notifications
  # resources :orders
  
  resources :users do
    resources :orders
  end
resources :ordermembers


  # root "orders#index"
  root to: 'orders#index'
  get '/invitedfriend/:id', to: 'orders#invitedfriends', as: 'invitedfriends'
  get '/joinedfriend/:id', to: 'orders#joinedfriends', as: 'joinedfriends' 

  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
