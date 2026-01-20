class CreateCommonFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :common_foods do |t|
      t.string :name, null: false
      t.integer :calories_per_serving, null: false
      t.string :serving_size
      t.timestamps
    end
    
    add_index :common_foods, :name, unique: true
  end
end
