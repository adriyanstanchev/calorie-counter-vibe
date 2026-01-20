# Calorie Counter Web App

A simple calorie counter web application built with Ruby and Sinatra.

## Features

- Add food entries with name and calories
- View all foods added today
- See total calories for the day
- Delete food entries
- Clean, modern UI

## Prerequisites

- Ruby (version 2.7 or higher)
- Bundler gem (usually comes with Ruby)

## Setup Instructions

1. **Install dependencies:**
   ```bash
   bundle install
   ```
   This reads the `Gemfile` and installs all required gems (Sinatra, SQLite3, etc.)

2. **Run the application:**
   ```bash
   bundle exec rackup
   ```
   Or alternatively:
   ```bash
   ruby app.rb
   ```

3. **Open your browser:**
   Navigate to `http://localhost:4567`

## Project Structure

- `app.rb` - Main Sinatra application with all routes
- `database.rb` - Database setup and helper methods
- `config.ru` - Rack configuration file
- `views/index.erb` - HTML template for the homepage
- `Gemfile` - Ruby dependencies
- `calories.db` - SQLite database (created automatically)

## How It Works

1. **Routes** (`app.rb`):
   - `GET /` - Shows the homepage with all foods
   - `POST /add` - Adds a new food entry
   - `DELETE /delete/:id` - Deletes a food entry

2. **Database** (`database.rb`):
   - Creates a `foods` table with columns: id, name, calories, created_at
   - Provides methods to add, delete, and query foods

3. **Views** (`views/index.erb`):
   - ERB (Embedded Ruby) template that generates HTML
   - Displays foods and total calories

## Learning Ruby Concepts

This app demonstrates:
- **Classes and methods** - `Database` class with class methods
- **Instance variables** - `@foods`, `@total_calories` (available in views)
- **Blocks** - `.each do |food|` for iterating
- **Hashes** - `params`, `session`, database results
- **String interpolation** - `"Hello #{name}"`
- **Conditionals** - `if`, `unless`
- **Sinatra routes** - `get`, `post`, `delete`

## Switching to Rails Later

If you want to switch to Rails later, the concepts are similar:
- Routes work similarly (just defined in `config/routes.rb`)
- Database operations use ActiveRecord (similar to our `Database` class)
- Views use ERB templates (same syntax)
- The main difference is Rails has more conventions and structure
