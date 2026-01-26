Rails.application.routes.draw do
  # Authentication routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  
  # Profile routes
  get '/profile', to: 'users#show', as: 'profile'
  patch '/profile', to: 'users#update'
  
  # Root route - show the main page (requires login)
  root 'foods#index'
  
  # Food routes (require login)
  resources :foods, only: [:create, :update, :destroy]
  get '/foods/:id/edit', to: 'foods#edit', as: 'edit_food'
  
  # Search endpoint for common foods
  get '/search_foods', to: 'foods#search'
end
