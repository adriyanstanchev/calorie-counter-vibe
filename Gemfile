# Gemfile - This file lists all the Ruby gems (libraries) your app needs
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

# Rails - Web framework
gem 'rails', '~> 8.1.2'

# SQLite3 - Database driver for SQLite
gem 'sqlite3', '~> 1.7'

# Puma - Web server
gem 'puma', '~> 6.0'

# Password hashing for authentication
gem 'bcrypt', '~> 3.1.7'

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem 'web-console', '>= 4.1.0'
end
