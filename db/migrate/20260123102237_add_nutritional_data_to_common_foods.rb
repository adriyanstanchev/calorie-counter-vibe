class AddNutritionalDataToCommonFoods < ActiveRecord::Migration[7.2]
  def change
    add_column :common_foods, :protein, :decimal
    add_column :common_foods, :fat, :decimal
    add_column :common_foods, :carbs, :decimal
    add_column :common_foods, :fiber, :decimal
    add_column :common_foods, :sugar, :decimal
    add_column :common_foods, :sodium, :decimal
  end
end
