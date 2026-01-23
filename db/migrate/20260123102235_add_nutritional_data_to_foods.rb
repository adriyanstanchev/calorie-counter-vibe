class AddNutritionalDataToFoods < ActiveRecord::Migration[7.2]
  def change
    add_column :foods, :protein, :decimal
    add_column :foods, :fat, :decimal
    add_column :foods, :carbs, :decimal
    add_column :foods, :fiber, :decimal
    add_column :foods, :sugar, :decimal
    add_column :foods, :sodium, :decimal
  end
end
