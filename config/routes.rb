Rails.application.routes.draw do
  resources :notifications
  # resources :orders
  devise_for :users
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
