Rails.application.routes.draw do
  # A singleton resource and so no paths requiring ids are generated
  # Also, don't want to support editing of the session
  resource :session, only: [:new, :create, :destroy]
  resources :users
  
  get 'home', to: 'home#index', as: :home
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'home#index'
end
