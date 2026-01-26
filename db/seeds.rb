# Seed common foods database with nutritional data
# Format: [name, calories, serving, protein, fat, carbs, fiber, sugar, sodium, base_quantity]
common_foods = [
  # Fruits
  ['Apple', 95, '1 medium', 0.5, 0.3, 25.0, 4.4, 19.0, 2.0, 1.0],
  ['Banana', 105, '1 medium', 1.3, 0.4, 27.0, 3.1, 14.4, 1.0, 1.0],
  ['Orange', 62, '1 medium', 1.2, 0.2, 15.4, 3.1, 12.2, 0.0, 1.0],
  ['Strawberries', 49, '1 cup', 1.0, 0.5, 11.7, 3.0, 7.4, 1.0, 1.0],
  ['Grapes', 62, '1 cup', 0.6, 0.2, 16.0, 0.8, 15.0, 3.0, 1.0],
  ['Blueberries', 84, '1 cup', 1.1, 0.5, 21.0, 3.6, 15.0, 1.0, 1.0],
  ['Watermelon', 46, '1 cup', 0.9, 0.2, 11.5, 0.6, 9.4, 1.0, 1.0],
  ['Mango', 99, '1 cup', 1.4, 0.6, 25.0, 2.6, 23.0, 1.0, 1.0],
  ['Pineapple', 82, '1 cup', 0.9, 0.2, 22.0, 2.3, 16.0, 1.0, 1.0],
  ['Peach', 59, '1 medium', 1.4, 0.4, 14.0, 2.3, 13.0, 0.0, 1.0],
  
  # Proteins
  ['Chicken Breast', 231, '100g', 31.0, 3.6, 0.0, 0.0, 0.0, 74.0, 100.0],
  ['Salmon', 206, '100g', 22.0, 12.0, 0.0, 0.0, 0.0, 44.0, 100.0],
  ['Tuna', 144, '100g', 30.0, 0.5, 0.0, 0.0, 0.0, 37.0, 100.0],
  ['Ground Beef', 250, '100g', 26.0, 17.0, 0.0, 0.0, 0.0, 72.0, 100.0],
  ['Turkey Breast', 135, '100g', 30.0, 1.0, 0.0, 0.0, 0.0, 69.0, 100.0],
  ['Pork Chop', 242, '100g', 27.0, 14.0, 0.0, 0.0, 0.0, 62.0, 100.0],
  ['Eggs', 70, '1 large', 6.3, 4.8, 0.6, 0.0, 0.6, 62.0, 1.0],
  ['Tofu', 76, '100g', 8.0, 4.8, 1.9, 0.3, 0.6, 7.0, 100.0],
  ['Greek Yogurt', 100, '100g', 10.0, 0.4, 3.6, 0.0, 3.6, 36.0, 100.0],
  
  # Grains & Carbs
  ['Rice', 130, '1 cup cooked', 2.7, 0.3, 28.0, 0.4, 0.1, 1.0, 1.0],
  ['Pasta', 131, '1 cup cooked', 5.0, 1.1, 25.0, 1.8, 0.6, 1.0, 1.0],
  ['Quinoa', 222, '1 cup cooked', 8.1, 3.6, 39.0, 5.2, 0.0, 13.0, 1.0],
  ['Oatmeal', 154, '1 cup cooked', 6.0, 3.2, 27.0, 4.0, 1.0, 3.0, 1.0],
  ['Bread', 79, '1 slice', 2.7, 1.0, 14.9, 0.8, 1.4, 149.0, 1.0],
  ['Bagel', 245, '1 medium', 9.5, 1.5, 48.0, 2.0, 5.0, 430.0, 1.0],
  ['White Rice', 205, '1 cup cooked', 4.3, 0.4, 45.0, 0.6, 0.1, 1.6, 1.0],
  ['Brown Rice', 216, '1 cup cooked', 5.0, 1.8, 45.0, 3.5, 0.4, 10.0, 1.0],
  
  # Vegetables
  ['Broccoli', 55, '1 cup', 3.0, 0.6, 11.0, 5.1, 2.6, 33.0, 1.0],
  ['Carrots', 52, '1 cup', 1.2, 0.3, 12.3, 3.6, 6.1, 88.0, 1.0],
  ['Spinach', 7, '1 cup', 0.9, 0.1, 1.1, 0.7, 0.1, 24.0, 1.0],
  ['Tomato', 32, '1 medium', 1.6, 0.4, 7.0, 2.2, 4.7, 6.0, 1.0],
  ['Potato', 161, '1 medium', 4.3, 0.2, 37.0, 4.0, 1.7, 17.0, 1.0],
  ['Sweet Potato', 103, '1 medium', 2.0, 0.2, 24.0, 3.8, 7.4, 41.0, 1.0],
  ['Bell Pepper', 31, '1 medium', 1.0, 0.3, 7.0, 2.5, 5.0, 4.0, 1.0],
  ['Cucumber', 16, '1 cup', 0.7, 0.1, 4.0, 0.5, 2.0, 2.0, 1.0],
  ['Zucchini', 20, '1 cup', 1.5, 0.4, 3.9, 1.2, 3.0, 8.0, 1.0],
  ['Cauliflower', 27, '1 cup', 2.1, 0.3, 5.3, 2.1, 2.0, 30.0, 1.0],
  ['Kale', 33, '1 cup', 2.9, 0.6, 6.0, 1.3, 0.6, 30.0, 1.0],
  ['Lettuce', 5, '1 cup', 0.5, 0.1, 1.0, 0.5, 0.5, 5.0, 1.0],
  
  # Dairy
  ['Milk', 103, '1 cup', 8.0, 2.4, 12.0, 0.0, 12.0, 107.0, 1.0],
  ['Yogurt', 150, '1 cup', 13.0, 3.8, 17.0, 0.0, 17.0, 113.0, 1.0],
  ['Cheese', 113, '1 oz', 7.0, 9.0, 0.4, 0.0, 0.1, 176.0, 1.0],
  ['Cottage Cheese', 163, '1 cup', 28.0, 2.3, 6.0, 0.0, 6.0, 918.0, 1.0],
  ['Mozzarella', 85, '1 oz', 6.0, 6.0, 1.0, 0.0, 0.5, 176.0, 1.0],
  
  # Fats & Oils
  ['Butter', 102, '1 tbsp', 0.1, 11.5, 0.0, 0.0, 0.0, 82.0, 1.0],
  ['Olive Oil', 119, '1 tbsp', 0.0, 13.5, 0.0, 0.0, 0.0, 0.3, 1.0],
  ['Avocado', 234, '1 medium', 3.0, 21.0, 12.0, 10.0, 1.0, 10.0, 1.0],
  
  # Nuts & Seeds
  ['Almonds', 164, '1 oz', 6.0, 14.2, 6.1, 3.5, 1.2, 1.0, 1.0],
  ['Peanut Butter', 94, '1 tbsp', 3.5, 8.0, 3.6, 1.0, 1.4, 73.0, 1.0],
  ['Walnuts', 185, '1 oz', 4.3, 18.5, 3.9, 1.9, 0.7, 1.0, 1.0],
  ['Cashews', 157, '1 oz', 5.2, 12.4, 8.6, 0.9, 1.7, 3.0, 1.0],
  ['Chia Seeds', 138, '1 oz', 4.7, 8.7, 12.0, 10.0, 0.0, 5.0, 1.0],
  
  # Snacks & Treats
  ['Chocolate', 155, '1 oz', 2.0, 9.0, 15.0, 1.7, 14.0, 5.0, 1.0],
  ['Pizza', 266, '1 slice', 12.0, 10.0, 33.0, 2.0, 3.0, 551.0, 1.0],
  ['Hamburger', 354, '1 patty', 25.0, 20.0, 33.0, 1.0, 5.0, 497.0, 1.0],
  ['French Fries', 365, '1 medium serving', 4.0, 17.0, 63.0, 5.0, 0.3, 246.0, 1.0],
  ['Ice Cream', 207, '1 cup', 3.5, 11.0, 24.0, 0.7, 21.0, 84.0, 1.0],
  ['Cookies', 142, '1 cookie', 1.5, 6.0, 21.0, 0.6, 12.0, 85.0, 1.0],
  ['Chips', 152, '1 oz', 2.0, 10.0, 15.0, 1.0, 0.2, 170.0, 1.0],
  
  # Beverages
  ['Orange Juice', 112, '1 cup', 1.7, 0.5, 26.0, 0.5, 21.0, 2.0, 1.0],
  ['Apple Juice', 114, '1 cup', 0.2, 0.3, 28.0, 0.2, 24.0, 10.0, 1.0],
  ['Coffee', 2, '1 cup', 0.3, 0.0, 0.0, 0.0, 0.0, 5.0, 1.0],
  ['Green Tea', 2, '1 cup', 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 1.0]
]

common_foods.each do |name, calories, serving, protein, fat, carbs, fiber, sugar, sodium, base_quantity|
  CommonFood.find_or_create_by(name: name) do |food|
    food.calories_per_serving = calories
    food.serving_size = serving
    food.protein = protein
    food.fat = fat
    food.carbs = carbs
    food.fiber = fiber
    food.sugar = sugar
    food.sodium = sodium
    food.base_quantity = base_quantity
  end
end

puts "Seeded #{common_foods.length} common foods with nutritional data"

# Create seed users
seed_users = [
  { email: 'bob@example.com', password: '1' },
  { email: 'bart@example.com', password: '1' },
  { email: 'lisa@example.com', password: '1' }
]

seed_users.each do |user_data|
  user = User.find_or_initialize_by(email: user_data[:email])
  if user.new_record?
    user.password = user_data[:password]
    user.password_confirmation = user_data[:password]
    user.save!
  end
  
  # Clear existing foods for seed users to avoid duplicates
  user.foods.destroy_all
  
  # Generate food entries for the last 7 days
  (0..6).each do |days_ago|
    date = Date.current - days_ago.days
    
    # Different meal patterns for each user
    case user.email
    when 'bob@example.com'
      # Bob - active, protein-focused
      meals = [
        ['Oatmeal', 1.5, 8, 3.2, 27, 4, 1, 3],
        ['Eggs', 3, 18.9, 14.4, 1.8, 0, 1.8, 186],
        ['Chicken Breast', 200, 62, 7.2, 0, 0, 0, 148],
        ['Rice', 1.5, 4.05, 0.45, 42, 0.6, 0.15, 1.5],
        ['Broccoli', 2, 6, 1.2, 22, 10.2, 5.2, 66],
        ['Salmon', 150, 33, 18, 0, 0, 0, 66],
        ['Sweet Potato', 1, 2, 0.2, 24, 3.8, 7.4, 41],
        ['Greek Yogurt', 200, 20, 0.8, 7.2, 0, 7.2, 72]
      ]
    when 'bart@example.com'
      # Bart - varied, balanced
      meals = [
        ['Bread', 2, 5.4, 2, 29.8, 1.6, 2.8, 298],
        ['Peanut Butter', 2, 7, 16, 7.2, 2, 2.8, 146],
        ['Banana', 1, 1.3, 0.4, 27, 3.1, 14.4, 1],
        ['Pasta', 1.5, 7.5, 1.65, 37.5, 2.7, 0.9, 1.5],
        ['Tomato', 2, 3.2, 0.8, 14, 4.4, 9.4, 12],
        ['Cheese', 2, 14, 18, 0.8, 0, 0.2, 352],
        ['Apple', 1, 0.5, 0.3, 25, 4.4, 19, 2],
        ['Milk', 1, 8, 2.4, 12, 0, 12, 107]
      ]
    when 'lisa@example.com'
      # Lisa - health-conscious, plant-focused
      meals = [
        ['Oatmeal', 1, 6, 3.2, 27, 4, 1, 3],
        ['Blueberries', 1, 1.1, 0.5, 21, 3.6, 15, 1],
        ['Spinach', 2, 1.8, 0.2, 2.2, 1.4, 0.2, 48],
        ['Quinoa', 1, 8.1, 3.6, 39, 5.2, 0, 13],
        ['Bell Pepper', 2, 2, 0.6, 14, 5, 10, 8],
        ['Tofu', 150, 12, 7.2, 2.85, 0.45, 0.9, 10.5],
        ['Avocado', 0.5, 1.5, 10.5, 6, 5, 0.5, 5],
        ['Almonds', 1, 6, 14.2, 6.1, 3.5, 1.2, 1],
        ['Kale', 2, 5.8, 1.2, 12, 2.6, 1.2, 60]
      ]
    end
    
    meals.each do |food_name, quantity, protein, fat, carbs, fiber, sugar, sodium|
      common_food = CommonFood.find_by(name: food_name)
      next unless common_food
      
      # Calculate nutritional values based on quantity
      multiplier = quantity / common_food.base_quantity
      
      user.foods.create!(
        name: food_name,
        calories: (common_food.calories_per_serving * multiplier).round,
        protein: protein,
        fat: fat,
        carbs: carbs,
        fiber: fiber,
        sugar: sugar,
        sodium: sodium,
        created_at: date.beginning_of_day + rand(8..20).hours + rand(0..59).minutes
      )
    end
  end
  
  puts "Created user #{user.email} with food entries for the last 7 days"
end

puts "Seeding complete!"
