Rails.application.routes.draw do
  devise_for :users 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#index"
  resources :users do
    member do #memberによりidの識別がされるようになる（:idと同じ）
      get :followings, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  #dm機能
  resources :rooms, only: [:index, :create, :show]
  resources :messages, only: [:create, :edit, :update, :destroy]

  
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    get :search, on: :collection #urlにidをつけない
  end

  #通知機能
  resources :notifications, only: [:index, :destroy]
  
end
