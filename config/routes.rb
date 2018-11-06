Rails.application.routes.draw do
  get 'areas/new'
  get 'areas/create'
  get 'gyms/new'
  get 'gyms/create'
 
  root to: 'logs#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users
  post 'logs',to: 'logs#create', as: 'create_log'
  resources :logs
  resources :spots
  resources :gyms, only: [:new, :create]
  resources :areas, only: [:new, :create]  
  resources :problems
      
end
