Rails.application.routes.draw do
  resources :man_with_animals
  resources :animals
  resources :men
	root 'man_with_animals#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
