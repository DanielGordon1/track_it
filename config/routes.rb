Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :trackers, only: [:show]

  resources :tracks, only: [:show, :new, :create, :destroy] do
    member do
      patch :upvote
      patch :downvote
    end

    resources :comments, only: [:create, :destroy]
  end

  resource :profile, only: [:show, :edit, :update, :destroy]
end

