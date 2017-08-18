Rails.application.routes.draw do
  devise_scope :user do
    root to: 'users#index'
  end

  devise_for :users

  resources :users, only: [:index, :show]
  resources :transactions, only: [:edit, :update]

  resources :users do
    resources :transactions, only: [:create, :destroy]
    resources :tickets, only: [:create, :destroy]
  end

  resources :transactions do
    resources :tickets, only: [:update]
  end
end
