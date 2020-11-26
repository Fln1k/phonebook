Rails.application.routes.draw do
	root to: 'contacts#index'
	put '/contacts/update_via_file'
	get "user/contacts", to: 'users#contacts'
	devise_for :users
	resources :users
	resources :contacts
end
