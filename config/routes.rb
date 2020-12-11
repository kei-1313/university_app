Rails.application.routes.draw do
  root to: "homes#index"
  devise_for :users 
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    member do #memberによりidの識別がされるようになる（:idと同じ）
      get :followings, :followers
    end
    get :search, on: :collection #urlにidをつけない
  end
  resources :relationships, only: [:create, :destroy]

  #dm機能
  resources :rooms, only: [:index, :create, :show]
  resources :messages, only: [:create, :edit, :update, :destroy]

  
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    get :search, on: :collection #urlにidをつけない
    resources :tags, only: [:show]
  end

  #通知機能
  resources :notifications, only: [:index, :destroy]
  
end
