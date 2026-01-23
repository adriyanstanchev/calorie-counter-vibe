Rails.application.routes.draw do
  # Authentication routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  
  # Root route - show the main page (requires login)
  root 'foods#index'
  
  # Food routes (require login)
  resources :foods, only: [:create, :destroy]
  
  # Search endpoint for common foods
  get '/search_foods', to: 'foods#search'
end
