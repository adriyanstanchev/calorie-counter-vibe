# app.rb - Main Sinatra application file
# This is where we define all the routes (URLs) and what happens when users visit them

# require loads external libraries
require 'sinatra'
require 'json'
require_relative 'database'

# Enable sessions - this lets us store temporary data (like flash messages)
# Sessions use cookies to remember information between page requests
enable :sessions

# Enable method override - allows forms to use DELETE/PUT methods via hidden _method input
# HTML forms only support GET and POST, so this lets us simulate DELETE requests
set :method_override, true

# This is a Sinatra route handler
# get '/' means: when someone visits the root URL (http://localhost:4567/), do this
get '/' do
  # Database.all_foods gets all food entries from the database
  # @foods is an instance variable - it's available in the view template
  @foods = Database.all_foods

  # Calculate total calories for today
  @total_calories = Database.total_calories_today || 0

  # erb is a templating system - it processes the file in views/index.erb
  # The @ variables we set above are available in that template
  erb :index
end

# API endpoint to search common foods
get '/search_foods' do
  query = params[:q] || ''
  foods = Database.search_common_foods(query)
  content_type :json
  foods.to_json
end

# POST route - handles form submissions
# When the form on the homepage is submitted, it sends a POST request here
post '/add' do
  # params is a hash containing all form data
  # params[:name] gets the value from the form field named "name"
  name = params[:name]
  calories = params[:calories].to_i  # .to_i converts string to integer

  # Validate that we have both name and calories
  # In Ruby, ! means "not" (opposite)
  if !name.empty? && calories > 0
    # Add the food to the database
    Database.add_food(name, calories)
    
    # Set a success message in the session
    # session is a hash that persists between requests
    session[:message] = "Added #{name} (#{calories} calories)!"
    session[:message_type] = "success"
  else
    # Set an error message
    session[:message] = "Please enter both name and calories!"
    session[:message_type] = "error"
  end

  # redirect sends the user back to the homepage
  # This prevents duplicate form submissions if they refresh
  redirect '/'
end

# DELETE route - handles deleting a food entry
# :id is a route parameter - it captures part of the URL
# For example, /delete/5 would set params[:id] to "5"
delete '/delete/:id' do
  # params[:id] gets the ID from the URL
  # .to_i converts the string to an integer
  id = params[:id].to_i

  # Delete the food entry from the database
  Database.delete_food(id)

  # Set a delete message (will be displayed in red)
  session[:message] = "Food entry deleted!"
  session[:message_type] = "delete"

  # Redirect back to homepage
  redirect '/'
end

# This is a Sinatra helper method
# It runs before each request (before any route handler)
before do
  # Get any message from the session and make it available to views
  # @message is an instance variable available in all views
  @message = session[:message]
  @message_type = session[:message_type]
  
  # Clear the message after reading it (so it only shows once)
  session[:message] = nil
  session[:message_type] = nil
end
