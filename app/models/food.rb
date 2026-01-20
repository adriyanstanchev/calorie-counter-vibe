# Food model - represents a food entry logged by the user
class Food < ApplicationRecord
  # ActiveRecord automatically provides:
  # - id, name, calories, created_at, updated_at columns
  # - methods like .all, .create, .find, .destroy, etc.
  
  validates :name, presence: true
  validates :calories, presence: true, numericality: { greater_than: 0 }
  
  # Scope to get foods from today
  scope :today, -> { where('DATE(created_at) = DATE(?)', Time.current) }
  
  # Class method to get total calories for today
  def self.total_calories_today
    today.sum(:calories) || 0
  end
end
