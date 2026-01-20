# Seed common foods database
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
  CommonFood.find_or_create_by(name: name) do |food|
    food.calories_per_serving = calories
    food.serving_size = serving
  end
end

puts "Seeded #{common_foods.length} common foods"
