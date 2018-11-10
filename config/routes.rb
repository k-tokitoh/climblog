Rails.application.routes.draw do

  root to: 'logs#index'
  resources :logs
  post 'logs',to: 'logs#create', as: 'create_log'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users
  
  resources :spots
  
  resources :gyms, only: [:new, :create]
  
  resources :areas, only: [:new, :create]  
  
  resources :problems, only: [:index, :new, :create, :show, :destroy]
  
  resources :follow_relations, only: [:create, :destroy]

  resources :like_relations, only: [:create, :destroy]

      
end
