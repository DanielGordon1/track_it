Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  root to: 'pages#home'

  # Souncloud Omniauth

  devise_for :users

  get '/soundcloud/auth', to: 'soundcloud#auth'
  get '/soundcloud/callback', to: 'soundcloud#callback'
  
  resources :trackers, only: [:show]

  resources :tracks, only: [:show, :new, :create, :destroy] do
    member do
      patch :upvote
  
    end

    resources :comments, only: [:create, :destroy]
  end

  resource :profile, only: [:show, :edit, :update, :destroy]
end

