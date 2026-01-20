# config.ru - Rack configuration file
# Rack is the web server interface that Sinatra uses
# This file tells the server how to run your application

# require_relative loads a Ruby file from the same directory
# The '.rb' extension is optional in Ruby
require_relative 'app'

# run tells Rack to start the Sinatra application
# Sinatra::Application is the main app class defined in app.rb
run Sinatra::Application
