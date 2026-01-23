class AddUserIdToFoods < ActiveRecord::Migration[7.1]
  def up
    # First, delete any existing foods (since we're adding authentication)
    execute "DELETE FROM foods"
    
    # Then add the user_id column
    add_reference :foods, :user, null: false, foreign_key: true
  end
  
  def down
    remove_reference :foods, :user, foreign_key: true
  end
end
