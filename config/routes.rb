Rails.application.routes.draw do
  devise_scope :user do
    root to: 'users#index'
  end

  devise_for :users, skip: [:registrations]
    as :user do
      get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
      put 'users' => 'devise/registrations#update', as: 'user_registration'
  end

  resources :users, only: [:index, :show]
  resources :transactions, only: [:index, :create, :update]
end
