class FoodsController < ApplicationController
  # GET / - Show all foods and form
  def index
    # Get date from params or default to today
    @selected_date = params[:date] ? Date.parse(params[:date]) : Date.current
    @foods = Food.for_date(current_user, @selected_date)
    @nutritional_totals = Food.nutritional_totals_for_date(current_user, @selected_date)
    @health_score = Food.health_score_for_date(current_user, @selected_date)
    @food = nil # Ensure @food is nil for new entries
    
    # Get date range for navigation
    @earliest_date = current_user.foods.minimum(:created_at)&.to_date || Date.current
    @latest_date = current_user.foods.maximum(:created_at)&.to_date || Date.current
    
    # Get recommended calories from user profile
    @recommended_calories = current_user.recommended_calories
    
    # Check if we should show profile modal (set in session after registration)
    @show_profile_modal = session[:show_profile_modal] && current_user.profile_complete?
    session.delete(:show_profile_modal) if @show_profile_modal
  end
  
  # POST /foods - Create a new food entry
  def create
    name = params[:name]
    calories = params[:calories].to_f
    protein = params[:protein].to_f
    fat = params[:fat].to_f
    carbs = params[:carbs].to_f
    fiber = params[:fiber].to_f
    sugar = params[:sugar].to_f
    sodium = params[:sodium].to_f
    
    # Use selected date or default to today
    selected_date = params[:date] ? Date.parse(params[:date]) : Date.current
    
    if name.present? && calories > 0
      food = current_user.foods.create(
        name: name,
        calories: calories,
        protein: protein,
        fat: fat,
        carbs: carbs,
        fiber: fiber,
        sugar: sugar,
        sodium: sodium,
        created_at: selected_date.beginning_of_day + Time.current.hour.hours + Time.current.min.minutes
      )
      session[:message] = "Added #{name} (#{calories.round} calories)!"
      session[:message_type] = "success"
    else
      session[:message] = "Please enter both name and calories!"
      session[:message_type] = "error"
    end
    
    redirect_to root_path(date: selected_date, anchor: 'form-section')
  end
  
  # GET /foods/:id/edit - Show edit form (populated with food data)
  def edit
    @food = current_user.foods.find(params[:id])
    @selected_date = @food.created_at.to_date
    @foods = Food.for_date(current_user, @selected_date)
    @nutritional_totals = Food.nutritional_totals_for_date(current_user, @selected_date)
    @health_score = Food.health_score_for_date(current_user, @selected_date)
    
    @earliest_date = current_user.foods.minimum(:created_at)&.to_date || Date.current
    @latest_date = current_user.foods.maximum(:created_at)&.to_date || Date.current
    
    render :index
  end
  
  # PATCH/PUT /foods/:id - Update a food entry
  def update
    food = current_user.foods.find(params[:id])
    selected_date = food.created_at.to_date
    
    name = params[:name]
    calories = params[:calories].to_f
    protein = params[:protein].to_f
    fat = params[:fat].to_f
    carbs = params[:carbs].to_f
    fiber = params[:fiber].to_f
    sugar = params[:sugar].to_f
    sodium = params[:sodium].to_f
    
    if name.present? && calories > 0
      food.update(
        name: name,
        calories: calories,
        protein: protein,
        fat: fat,
        carbs: carbs,
        fiber: fiber,
        sugar: sugar,
        sodium: sodium
      )
      session[:message] = "Updated #{name} (#{calories.round} calories)!"
      session[:message_type] = "success"
    else
      session[:message] = "Please enter both name and calories!"
      session[:message_type] = "error"
    end
    
    redirect_to root_path(date: selected_date, anchor: 'form-section')
  end
  
  # DELETE /foods/:id - Delete a food entry
  def destroy
    food = current_user.foods.find(params[:id])
    selected_date = food.created_at.to_date
    food.destroy
    session[:message] = "Food entry deleted!"
    session[:message_type] = "delete"
    redirect_to root_path(date: selected_date, anchor: 'form-section')
  end
  
  # GET /search_foods - API endpoint to search common foods
  def search
    query = params[:q] || ''
    foods = CommonFood.search(query)
    render json: foods
  end
end
