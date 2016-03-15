Rails.application.routes.draw do

  root to: 'tracks#index'

  devise_for :users

  resources :trackers, only: [:show]

  resources :tracks, only: [:show, :new, :create, :destroy] do
    member do
      patch :upvote
    end

    resources :comments, only: [:new, :create, :destroy]
  end

  resource :profile, only: [:show, :edit, :update, :destroy]
end
