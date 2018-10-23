Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    
    root to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    resources :users
    resources :logs
    resources :spots
    # get 'problems/:spot_id/:grade', to: 'problems#index'
    resources :problems
    
end
