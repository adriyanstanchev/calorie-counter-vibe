# CommonFood model - represents foods in the reference database
class CommonFood < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :calories_per_serving, presence: true, numericality: { greater_than: 0 }
  
  # Search common foods by name (case-insensitive)
  def self.search(query)
    where("LOWER(name) LIKE ?", "%#{query.downcase}%")
      .order(:name)
      .limit(20)
  end
end
