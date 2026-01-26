class User < ApplicationRecord
  has_secure_password
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 1 }, if: -> { new_record? || !password.nil? }
  
  has_many :foods, dependent: :destroy
  
  # Calculate BMI (Body Mass Index)
  def bmi
    return nil unless height && weight && height > 0 && weight > 0
    # BMI = weight (kg) / height (m)²
    (weight / (height / 100.0) ** 2).round(1)
  end
  
  # Get BMI category
  def bmi_category
    return nil unless bmi
    case bmi
    when 0...18.5
      "Underweight"
    when 18.5...25
      "Normal"
    when 25...30
      "Overweight"
    else
      "Obese"
    end
  end
  
  # Calculate BMR (Basal Metabolic Rate) using Mifflin-St Jeor Equation
  def bmr
    return nil unless height && weight && age && gender
    return nil if height <= 0 || weight <= 0 || age <= 0
    
    # BMR = 10 * weight(kg) + 6.25 * height(cm) - 5 * age(years) + s
    # s = +5 for males, -161 for females
    base_bmr = (10 * weight) + (6.25 * height) - (5 * age)
    base_bmr + (gender == 'male' ? 5 : -161)
  end
  
  # Calculate TDEE (Total Daily Energy Expenditure) based on activity level
  def tdee
    return nil unless bmr && activity_level
    
    activity_multipliers = {
      'sedentary' => 1.2,      # Little or no exercise
      'light' => 1.375,        # Light exercise 1-3 days/week
      'moderate' => 1.55,      # Moderate exercise 3-5 days/week
      'active' => 1.725,       # Hard exercise 6-7 days/week
      'very_active' => 1.9     # Very hard exercise, physical job
    }
    
    multiplier = activity_multipliers[activity_level] || 1.2
    (bmr * multiplier).round
  end
  
  # Calculate recommended daily calories based on goal
  def recommended_calories
    return nil unless tdee && goal
    
    case goal
    when 'lose'
      tdee - 500  # 500 cal deficit for ~1 lb/week loss
    when 'gain'
      tdee + 500  # 500 cal surplus for ~1 lb/week gain
    when 'maintain'
      tdee
    else
      tdee
    end
  end
  
  # Check if profile is complete
  def profile_complete?
    height.present? && weight.present? && age.present? && gender.present? && 
    activity_level.present? && goal.present?
  end
end

