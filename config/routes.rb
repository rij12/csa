Rails.application.routes.draw do
  resources :users
  
  namespace :api, defaults: {format: :json} do
    resources :users, except: [:new, :edit]
  end
  
  root 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
