Rails.application.routes.draw do

  root to: 'pages#home'

  # Souncloud Omniauth
  get '/soundcloud/auth', to: 'soundcloud#auth'
  get '/soundcloud/callback', to: 'soundcloud#callback'

  devise_for :users

  resources :trackers, only: [:show]

  resources :tracks, only: [:show, :new, :create, :destroy] do
    member do
      patch :upvote
    end

    resources :comments, only: [:create, :destroy]
  end

  resource :profile, only: [:show, :edit, :update, :destroy]
end

