# database.rb - Database setup and helper methods
# This file handles all database operations for our calorie counter

# require loads external libraries (gems)
require 'sqlite3'

# This is a Ruby class - a blueprint for creating objects
# Classes group related methods (functions) together
class Database
  # @@ creates a class variable (shared by all instances of the class)
  # This stores the database connection so we don't have to reconnect each time
  @@db = nil

  # self.method_name creates a class method (can be called without creating an instance)
  # You call it like: Database.setup
  def self.setup
    # Connect to SQLite database file
    # If the file doesn't exist, SQLite will create it automatically
    @@db = SQLite3::Database.new('calories.db')

    # results_as_hash = true makes database results come back as hash/object
    # Instead of arrays like [1, "Apple", 95], we get {id: 1, name: "Apple", calories: 95}
    @@db.results_as_hash = true

    # Create the foods table if it doesn't exist
    # execute runs a SQL command
    @@db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS foods (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        calories INTEGER NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    SQL

    # Create the common_foods table for food database
    @@db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS common_foods (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        calories_per_serving INTEGER NOT NULL,
        serving_size TEXT
      )
    SQL

    # Seed common foods if table is empty
    seed_common_foods if @@db.execute('SELECT COUNT(*) as count FROM common_foods').first['count'] == 0

    # Return the database connection
    @@db
  end

  # Class method to get the database connection
  def self.connection
    # If database hasn't been set up yet, set it up first
    setup if @@db.nil?
    @@db
  end

  # Class method to get all foods from the database
  def self.all_foods
    # SELECT * gets all columns from the foods table
    # ORDER BY created_at DESC sorts by newest first
    connection.execute('SELECT * FROM foods ORDER BY created_at DESC')
  end

  # Class method to add a new food entry
  # Parameters: name (string), calories (integer)
  def self.add_food(name, calories)
    # INSERT INTO adds a new row to the table
    # ? are placeholders that get filled with the values we pass
    # This prevents SQL injection attacks
    connection.execute('INSERT INTO foods (name, calories) VALUES (?, ?)', [name, calories])
  end

  # Class method to delete a food entry by its ID
  def self.delete_food(id)
    # DELETE FROM removes rows matching the condition
    connection.execute('DELETE FROM foods WHERE id = ?', [id])
  end

  # Class method to get total calories for today
  def self.total_calories_today
    # SUM(calories) adds up all the calories
    # DATE(created_at) = DATE('now') filters to only today's entries
    result = connection.execute("SELECT SUM(calories) as total FROM foods WHERE DATE(created_at) = DATE('now')")
    
    # The result is an array with one hash: [{total: 150}]
    # If there are no entries, total will be nil
    # || 0 means "if total is nil, use 0 instead"
    result.first['total'] || 0
  end

  # Class method to search common foods by name
  def self.search_common_foods(query)
    # LIKE allows partial matching, % means "any characters"
    # LOWER converts to lowercase for case-insensitive search
    connection.execute(
      "SELECT * FROM common_foods WHERE LOWER(name) LIKE LOWER(?) ORDER BY name LIMIT 20",
      ["%#{query}%"]
    )
  end

  # Class method to get a common food by exact name
  def self.get_common_food(name)
    result = connection.execute(
      "SELECT * FROM common_foods WHERE LOWER(name) = LOWER(?) LIMIT 1",
      [name]
    )
    result.first
  end

  # Private method to seed common foods database
  def self.seed_common_foods
    common_foods = [
      ['Apple', 95, '1 medium'],
      ['Banana', 105, '1 medium'],
      ['Orange', 62, '1 medium'],
      ['Strawberries', 49, '1 cup'],
      ['Grapes', 62, '1 cup'],
      ['Chicken Breast', 231, '100g'],
      ['Salmon', 206, '100g'],
      ['Eggs', 70, '1 large'],
      ['Rice', 130, '1 cup cooked'],
      ['Pasta', 131, '1 cup cooked'],
      ['Bread', 79, '1 slice'],
      ['Milk', 103, '1 cup'],
      ['Yogurt', 150, '1 cup'],
      ['Cheese', 113, '1 oz'],
      ['Butter', 102, '1 tbsp'],
      ['Olive Oil', 119, '1 tbsp'],
      ['Avocado', 234, '1 medium'],
      ['Broccoli', 55, '1 cup'],
      ['Carrots', 52, '1 cup'],
      ['Spinach', 7, '1 cup'],
      ['Tomato', 32, '1 medium'],
      ['Potato', 161, '1 medium'],
      ['Sweet Potato', 103, '1 medium'],
      ['Oatmeal', 154, '1 cup cooked'],
      ['Almonds', 164, '1 oz'],
      ['Peanut Butter', 94, '1 tbsp'],
      ['Chocolate', 155, '1 oz'],
      ['Pizza', 266, '1 slice'],
      ['Hamburger', 354, '1 patty'],
      ['French Fries', 365, '1 medium serving']
    ]

    common_foods.each do |name, calories, serving|
      connection.execute(
        'INSERT OR IGNORE INTO common_foods (name, calories_per_serving, serving_size) VALUES (?, ?, ?)',
        [name, calories, serving]
      )
    end
  end
end
