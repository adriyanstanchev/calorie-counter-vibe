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
  
  # Search endpoint for common foods (must be before resources)
  get '/search_foods', to: 'foods#search', defaults: { format: :json }
  
  # Fetch nutritional data from external API (must be before resources)
  get '/fetch_food_data', to: 'foods#fetch_food_data', defaults: { format: :json }
  
  # Food routes (require login)
  resources :foods, only: [:create, :update, :destroy]
  get '/foods/:id/edit', to: 'foods#edit', as: 'edit_food'
end
