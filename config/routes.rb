Rails.application.routes.draw do
  root to: 'contacts#index'
  devise_for :users
  resources :users
  resources :contacts
end
