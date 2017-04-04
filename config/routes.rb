Rails.application.routes.draw do
    devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  get 'auth/:provider/callback', to: 'sessions#create'
  #devise_for :users
  resources :users
  root "users#index"
  post 'addFriend', to: "users#addFriend"
  get 'search', to: "users#index_friends"
  get 'acceptFriend/:id', to: "users#accept_friends"
  get 'declineFriend/:id', to: "users#decline_friends"
  get 'removeFriend/:id', to: "users#remove_friends"
  #get 'pending', to: "users#accept_friends"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
