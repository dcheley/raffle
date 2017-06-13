Rails.application.routes.draw do
  devise_scope :user do
    root to: 'users#index'
  end

  devise_for :users

  resources :users, only: [:index, :show, :edit]
end
