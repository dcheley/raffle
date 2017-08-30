Rails.application.routes.draw do
  get 'users/intro' => 'users#intro'
  
  devise_scope :user do
    root to: 'users#intro'
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
