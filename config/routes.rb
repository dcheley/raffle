Rails.application.routes.draw do
  get 'users/intro' => 'users#intro'
  get 'users/trash' => 'users#trash'
  get :send_payment_confirmation, to: 'users#send_payment_confirmation', as: :send_payment_confirmation
  get :restore_data, to: 'transactions#restore_data', as: :restore_data

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
