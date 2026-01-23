# SumLife

A comprehensive nutrition tracking web application built with Ruby on Rails.

## Features

- User authentication (email/password)
- Add food entries with comprehensive nutritional data (calories, protein, carbs, fat, fiber, sugar, sodium)
- Browse previous days with date navigation
- View nutritional totals and health score
- Interactive charts for macro and nutrient breakdown
- Food database with autocomplete search
- Quantity-based nutritional calculations
- Clean, modern UI

## Prerequisites

- Ruby 3.2.0 or higher
- Bundler gem (usually comes with Ruby)

## Setup Instructions

1. **Install dependencies:**
   ```bash
   bundle install
   ```
   This reads the `Gemfile` and installs all required gems (Rails, SQLite3, etc.)

2. **Setup the database:**
   ```bash
   rails db:migrate
   rails db:seed
   ```

3. **Run the application:**
   ```bash
   rails server -p 4567
   ```

4. **Open your browser:**
   Navigate to `http://localhost:4567`

## Project Structure

- `app/` - Application code
  - `controllers/` - Controllers handling requests
  - `models/` - ActiveRecord models (Food, User, CommonFood)
  - `views/` - ERB templates
- `config/` - Configuration files
  - `routes.rb` - Route definitions
  - `database.yml` - Database configuration
- `db/` - Database files
  - `migrate/` - Database migrations
  - `seeds.rb` - Seed data for common foods
- `Gemfile` - Ruby dependencies

## Technology Stack

- **Rails 7.2.3** - Web framework
- **Ruby 3.2.0** - Programming language
- **SQLite3** - Database
- **bcrypt** - Password hashing
- **Chart.js** - Data visualization (via CDN)
