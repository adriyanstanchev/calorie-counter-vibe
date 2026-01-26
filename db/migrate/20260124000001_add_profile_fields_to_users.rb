class AddProfileFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :height, :decimal, precision: 5, scale: 2
    add_column :users, :weight, :decimal, precision: 5, scale: 2
    add_column :users, :age, :integer
    add_column :users, :gender, :string
    add_column :users, :activity_level, :string
    add_column :users, :goal, :string
  end
end
