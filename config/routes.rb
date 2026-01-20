Rails.application.routes.draw do
  # Root route - show the main page
  root 'foods#index'
  
  # Food routes
  resources :foods, only: [:create, :destroy]
  
  # Search endpoint for common foods
  get '/search_foods', to: 'foods#search'
end
