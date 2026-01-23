class AddBaseQuantityToCommonFoods < ActiveRecord::Migration[7.2]
  def change
    add_column :common_foods, :base_quantity, :decimal, precision: 8, scale: 2, default: 1.0
  end
end
