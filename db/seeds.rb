# Seed common foods database with nutritional data
# Format: [name, calories, serving, protein, fat, carbs, fiber, sugar, sodium, base_quantity]
common_foods = [
  ['Apple', 95, '1 medium', 0.5, 0.3, 25.0, 4.4, 19.0, 2.0, 1.0],
  ['Banana', 105, '1 medium', 1.3, 0.4, 27.0, 3.1, 14.4, 1.0, 1.0],
  ['Orange', 62, '1 medium', 1.2, 0.2, 15.4, 3.1, 12.2, 0.0, 1.0],
  ['Strawberries', 49, '1 cup', 1.0, 0.5, 11.7, 3.0, 7.4, 1.0, 1.0],
  ['Grapes', 62, '1 cup', 0.6, 0.2, 16.0, 0.8, 15.0, 3.0, 1.0],
  ['Chicken Breast', 231, '100g', 31.0, 3.6, 0.0, 0.0, 0.0, 74.0, 100.0],
  ['Salmon', 206, '100g', 22.0, 12.0, 0.0, 0.0, 0.0, 44.0, 100.0],
  ['Eggs', 70, '1 large', 6.3, 4.8, 0.6, 0.0, 0.6, 62.0, 1.0],
  ['Rice', 130, '1 cup cooked', 2.7, 0.3, 28.0, 0.4, 0.1, 1.0, 1.0],
  ['Pasta', 131, '1 cup cooked', 5.0, 1.1, 25.0, 1.8, 0.6, 1.0, 1.0],
  ['Bread', 79, '1 slice', 2.7, 1.0, 14.9, 0.8, 1.4, 149.0, 1.0],
  ['Milk', 103, '1 cup', 8.0, 2.4, 12.0, 0.0, 12.0, 107.0, 1.0],
  ['Yogurt', 150, '1 cup', 13.0, 3.8, 17.0, 0.0, 17.0, 113.0, 1.0],
  ['Cheese', 113, '1 oz', 7.0, 9.0, 0.4, 0.0, 0.1, 176.0, 1.0],
  ['Butter', 102, '1 tbsp', 0.1, 11.5, 0.0, 0.0, 0.0, 82.0, 1.0],
  ['Olive Oil', 119, '1 tbsp', 0.0, 13.5, 0.0, 0.0, 0.0, 0.3, 1.0],
  ['Avocado', 234, '1 medium', 3.0, 21.0, 12.0, 10.0, 1.0, 10.0, 1.0],
  ['Broccoli', 55, '1 cup', 3.0, 0.6, 11.0, 5.1, 2.6, 33.0, 1.0],
  ['Carrots', 52, '1 cup', 1.2, 0.3, 12.3, 3.6, 6.1, 88.0, 1.0],
  ['Spinach', 7, '1 cup', 0.9, 0.1, 1.1, 0.7, 0.1, 24.0, 1.0],
  ['Tomato', 32, '1 medium', 1.6, 0.4, 7.0, 2.2, 4.7, 6.0, 1.0],
  ['Potato', 161, '1 medium', 4.3, 0.2, 37.0, 4.0, 1.7, 17.0, 1.0],
  ['Sweet Potato', 103, '1 medium', 2.0, 0.2, 24.0, 3.8, 7.4, 41.0, 1.0],
  ['Oatmeal', 154, '1 cup cooked', 6.0, 3.2, 27.0, 4.0, 1.0, 3.0, 1.0],
  ['Almonds', 164, '1 oz', 6.0, 14.2, 6.1, 3.5, 1.2, 1.0, 1.0],
  ['Peanut Butter', 94, '1 tbsp', 3.5, 8.0, 3.6, 1.0, 1.4, 73.0, 1.0],
  ['Chocolate', 155, '1 oz', 2.0, 9.0, 15.0, 1.7, 14.0, 5.0, 1.0],
  ['Pizza', 266, '1 slice', 12.0, 10.0, 33.0, 2.0, 3.0, 551.0, 1.0],
  ['Hamburger', 354, '1 patty', 25.0, 20.0, 33.0, 1.0, 5.0, 497.0, 1.0],
  ['French Fries', 365, '1 medium serving', 4.0, 17.0, 63.0, 5.0, 0.3, 246.0, 1.0]
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
