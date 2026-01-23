# Food model - represents a food entry logged by the user
class Food < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true
  validates :calories, presence: true, numericality: { greater_than: 0 }
  
  # Scope to get foods from a specific date
  scope :on_date, ->(date) { where('DATE(created_at) = ?', date.to_date) }
  scope :today, -> { where('DATE(created_at) = DATE(?)', Time.current) }
  
  # Class method to get foods for a specific date and user
  def self.for_date(user, date)
    where(user: user).on_date(date).order(created_at: :desc)
  end
  
  # Class method to get total calories for a specific date and user
  def self.total_calories_for_date(user, date)
    where(user: user).on_date(date).sum(:calories) || 0
  end
  
  # Class method to get total calories for today for a specific user
  def self.total_calories_today(user)
    total_calories_for_date(user, Date.current)
  end
  
  # Class method to get nutritional totals for a date
  def self.nutritional_totals_for_date(user, date)
    foods = where(user: user).on_date(date)
    {
      calories: foods.sum(:calories) || 0,
      protein: foods.sum(:protein) || 0,
      fat: foods.sum(:fat) || 0,
      carbs: foods.sum(:carbs) || 0,
      fiber: foods.sum(:fiber) || 0,
      sugar: foods.sum(:sugar) || 0,
      sodium: foods.sum(:sodium) || 0
    }
  end
  
  # Calculate health score for a date (0-100)
  # Based on: balanced macros, fiber intake, low sugar/sodium
  def self.health_score_for_date(user, date)
    totals = nutritional_totals_for_date(user, date)
    return 50 if totals[:calories] == 0 # Default score if no food logged
    
    score = 0
    max_score = 100
    
    # Calorie balance (20 points) - assuming 2000 cal/day target
    calorie_target = 2000
    calorie_ratio = [totals[:calories] / calorie_target.to_f, 1.0].min
    score += (20 * (1 - (calorie_ratio - 1).abs * 2)).clamp(0, 20)
    
    # Protein adequacy (20 points) - target: 0.8g per kg body weight, assume 70kg = 56g
    protein_target = 56
    protein_ratio = [totals[:protein] / protein_target.to_f, 1.5].min
    score += (20 * protein_ratio).clamp(0, 20)
    
    # Macro balance (20 points) - ideal: 30% protein, 30% fat, 40% carbs (by calories)
    total_macro_cals = (totals[:protein] * 4) + (totals[:fat] * 9) + (totals[:carbs] * 4)
    return score if total_macro_cals == 0
    
    protein_cal_pct = (totals[:protein] * 4) / total_macro_cals.to_f
    fat_cal_pct = (totals[:fat] * 9) / total_macro_cals.to_f
    carbs_cal_pct = (totals[:carbs] * 4) / total_macro_cals.to_f
    
    # Score based on how close to ideal ratios
    protein_score = 6.67 * (1 - (protein_cal_pct - 0.30).abs / 0.30).clamp(0, 1)
    fat_score = 6.67 * (1 - (fat_cal_pct - 0.30).abs / 0.30).clamp(0, 1)
    carbs_score = 6.67 * (1 - (carbs_cal_pct - 0.40).abs / 0.40).clamp(0, 1)
    score += protein_score + fat_score + carbs_score
    
    # Fiber intake (15 points) - target: 25g/day
    fiber_target = 25
    fiber_ratio = [totals[:fiber] / fiber_target.to_f, 1.5].min
    score += (15 * fiber_ratio).clamp(0, 15)
    
    # Low sugar (10 points) - target: < 50g/day
    sugar_target = 50
    sugar_penalty = totals[:sugar] > sugar_target ? (totals[:sugar] - sugar_target) / sugar_target.to_f : 0
    score += (10 * (1 - sugar_penalty.clamp(0, 1))).clamp(0, 10)
    
    # Low sodium (15 points) - target: < 2300mg/day
    sodium_target = 2300
    sodium_penalty = totals[:sodium] > sodium_target ? (totals[:sodium] - sodium_target) / sodium_target.to_f : 0
    score += (15 * (1 - sodium_penalty.clamp(0, 1))).clamp(0, 15)
    
    score.round
  end
end
