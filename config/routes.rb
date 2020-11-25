Rails.application.routes.draw do
  root to: 'contacts#index'
  put '/contact/update_via_file', to: 'contacts#update_via_file'
  devise_for :users
  resources :users
  resources :contacts
end
