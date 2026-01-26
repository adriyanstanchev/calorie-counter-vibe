class Food < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true
  validates :calories, presence: true, numericality: { greater_than: 0 }
  
  scope :on_date, ->(date) { where('DATE(created_at) = ?', date.to_date) }
  scope :today, -> { where('DATE(created_at) = DATE(?)', Time.current) }
  
  def self.for_date(user, date)
    where(user: user).on_date(date).order(created_at: :desc)
  end
  
  def self.total_calories_for_date(user, date)
    where(user: user).on_date(date).sum(:calories) || 0
  end
  
  def self.total_calories_today(user)
    total_calories_for_date(user, Date.current)
  end
  
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
  
  # Calculate health score (0-100) based on:
  # - Food quality (fiber density, low processed sugar, low sodium, protein density)
  # - Balanced macros (adjusted for partial days)
  # - Adequate protein and fiber (scaled for calorie intake)
  def self.health_score_for_date(user, date)
    totals = nutritional_totals_for_date(user, date)
    return 50 if totals[:calories] == 0
    
    score = 0
    calorie_target = 2000
    is_partial_day = totals[:calories] < (calorie_target * 0.5)
    
    if is_partial_day
      # For partial days, score based on calorie quality, not quantity
      calorie_ratio = totals[:calories] / (calorie_target * 0.3).to_f
      score += (15 * [calorie_ratio, 1.0].min).clamp(0, 15)
    else
      calorie_ratio = [totals[:calories] / calorie_target.to_f, 1.0].min
      score += (15 * (1 - (calorie_ratio - 1).abs * 2)).clamp(0, 15)
    end
    
    # Food quality: rewards high fiber density, low processed sugar, low sodium, good protein
    quality_score = 0
    foods = where(user: user).on_date(date)
    
    foods.each do |food|
      food_quality = 0
      
      if food.fiber > 0 && food.calories > 0
        fiber_per_cal = food.fiber / food.calories.to_f
        food_quality += 5 if fiber_per_cal > 0.05
      end
      
      if food.carbs > 0
        sugar_ratio = food.sugar / food.carbs.to_f
        food_quality += 5 if sugar_ratio < 0.5
      end
      
      food_quality += 5 if food.sodium < 100
      
      if food.protein > 0 && food.calories > 0
        protein_per_cal = food.protein / food.calories.to_f
        food_quality += 5 if protein_per_cal > 0.05
      end
      
      calorie_weight = food.calories / totals[:calories].to_f
      quality_score += food_quality * calorie_weight
    end
    
    score += (20 * [quality_score / 20.0, 1.0].min).clamp(0, 20)
    
    # Protein: scale target for partial days
    protein_target = 56
    if is_partial_day
      scaled_protein_target = protein_target * (totals[:calories] / calorie_target.to_f)
      protein_ratio = scaled_protein_target > 0 ? [totals[:protein] / scaled_protein_target.to_f, 1.5].min : 0
    else
      protein_ratio = [totals[:protein] / protein_target.to_f, 1.5].min
    end
    score += (15 * protein_ratio).clamp(0, 15)
    
    # Macro balance: ideal 30% protein, 30% fat, 40% carbs (by calories)
    total_macro_cals = (totals[:protein] * 4) + (totals[:fat] * 9) + (totals[:carbs] * 4)
    if total_macro_cals > 0
      protein_cal_pct = (totals[:protein] * 4) / total_macro_cals.to_f
      fat_cal_pct = (totals[:fat] * 9) / total_macro_cals.to_f
      carbs_cal_pct = (totals[:carbs] * 4) / total_macro_cals.to_f
      
      tolerance = is_partial_day ? 0.5 : 0.30
      
      protein_score = 5 * (1 - (protein_cal_pct - 0.30).abs / tolerance).clamp(0, 1)
      fat_score = 5 * (1 - (fat_cal_pct - 0.30).abs / tolerance).clamp(0, 1)
      carbs_score = 5 * (1 - (carbs_cal_pct - 0.40).abs / tolerance).clamp(0, 1)
      score += protein_score + fat_score + carbs_score
    end
    
    # Fiber: scale target for partial days
    fiber_target = 25
    if is_partial_day
      scaled_fiber_target = fiber_target * (totals[:calories] / calorie_target.to_f)
      fiber_ratio = scaled_fiber_target > 0 ? [totals[:fiber] / scaled_fiber_target.to_f, 1.5].min : 0
    else
      fiber_ratio = [totals[:fiber] / fiber_target.to_f, 1.5].min
    end
    score += (15 * fiber_ratio).clamp(0, 15)
    
    # Sugar: full points if under target, penalty if excessive
    sugar_target = 50
    if totals[:sugar] <= sugar_target
      score += 10
    else
      sugar_penalty = (totals[:sugar] - sugar_target) / sugar_target.to_f
      score += (10 * (1 - sugar_penalty.clamp(0, 1))).clamp(0, 10)
    end
    
    # Sodium: full points if under target, penalty if excessive
    sodium_target = 2300
    if totals[:sodium] <= sodium_target
      score += 10
    else
      sodium_penalty = (totals[:sodium] - sodium_target) / sodium_target.to_f
      score += (10 * (1 - sodium_penalty.clamp(0, 1))).clamp(0, 10)
    end
    
    score.round
  end
end
