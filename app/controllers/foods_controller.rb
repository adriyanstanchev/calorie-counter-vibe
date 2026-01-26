class FoodsController < ApplicationController
  # GET / - Show all foods and form
  def index
    # Get date from params or default to today
    @selected_date = if params[:date].present?
      begin
        Date.parse(params[:date])
      rescue ArgumentError
        Date.current
      end
    else
      Date.current
    end
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
  
  # GET /fetch_food_data - Fetch nutritional data from external API
  def fetch_food_data
    food_name = params[:name] || params[:q] || ''
    return render json: { error: 'Food name required' }, status: :bad_request if food_name.blank?
    
    # Try to find in our database first
    common_food = CommonFood.where("LOWER(name) = ?", food_name.downcase).first
    if common_food
      render json: {
        name: common_food.name,
        calories: common_food.calories_per_serving,
        protein: common_food.protein || 0,
        fat: common_food.fat || 0,
        carbs: common_food.carbs || 0,
        fiber: common_food.fiber || 0,
        sugar: common_food.sugar || 0,
        sodium: common_food.sodium || 0,
        base_quantity: common_food.base_quantity || 1,
        serving_size: common_food.serving_size || 'serving'
      }
      return
    end
    
    # Fetch from USDA FoodData Central API
    begin
      require 'net/http'
      require 'json'
      require 'timeout'
      
      # Search for the food with timeout
      api_key = ENV['USDA_API_KEY'] || 'DEMO_KEY'
      search_url = URI("https://api.nal.usda.gov/fdc/v1/foods/search?api_key=#{api_key}&query=#{URI.encode_www_form_component(food_name)}&pageSize=1")
      
      search_response = nil
      Timeout.timeout(5) do
        http = Net::HTTP.new(search_url.host, search_url.port)
        http.use_ssl = true
        http.read_timeout = 5
        http.open_timeout = 5
        
        request = Net::HTTP::Get.new(search_url)
        search_response = http.request(request)
      end
      
      Rails.logger.info "USDA API Response Code: #{search_response&.code}"
      Rails.logger.info "USDA API Response Body: #{search_response&.body&.first(500)}" if search_response
      
      if search_response && search_response.code == '200'
        data = JSON.parse(search_response.body)
        
        # Check for API errors (like rate limiting)
        if data['error']
          Rails.logger.error "USDA API Error: #{data['error']}"
          render json: { 
            error: "API rate limit exceeded. Please try again later or add your own USDA API key.",
            api_error: data['error']['message'] || 'API error'
          }, status: :service_unavailable
          return
        end
        
        Rails.logger.info "USDA API found #{data['foods']&.length || 0} foods"
        
        if data['foods'] && data['foods'].any?
          food = data['foods'].first
          nutrients = {}
          
          # Extract nutrients from foodDataCentral format
          food['foodNutrients']&.each do |nutrient|
            nutrient_id = nutrient['nutrientId']
            case nutrient_id
            when 1008  # Energy (kcal)
              nutrients[:calories] = nutrient['value'] || 0
            when 1003  # Protein
              nutrients[:protein] = nutrient['value'] || 0
            when 1004  # Fat
              nutrients[:fat] = nutrient['value'] || 0
            when 1005  # Carbs
              nutrients[:carbs] = nutrient['value'] || 0
            when 1079  # Fiber
              nutrients[:fiber] = nutrient['value'] || 0
            when 2000  # Sugar
              nutrients[:sugar] = nutrient['value'] || 0
            when 1093  # Sodium
              nutrients[:sodium] = (nutrient['value'] || 0) * 1000 # Convert from g to mg
            end
          end
          
          # USDA API returns nutrients per 100g by default
          # No need to scale if we're already getting per 100g data
          
          render json: {
            name: food['description'] || food_name,
            calories: nutrients[:calories] || 0,
            protein: nutrients[:protein] || 0,
            fat: nutrients[:fat] || 0,
            carbs: nutrients[:carbs] || 0,
            fiber: nutrients[:fiber] || 0,
            sugar: nutrients[:sugar] || 0,
            sodium: nutrients[:sodium] || 0,
            base_quantity: 100,
            serving_size: '100g'
          }
        else
          Rails.logger.warn "No foods found in USDA API response for: #{food_name}"
          render json: { error: 'Food not found' }, status: :not_found
        end
      else
        # API unavailable or error
        Rails.logger.error "USDA API error - Code: #{search_response&.code}, Body: #{search_response&.body&.first(200)}"
        render json: { error: 'Food not found' }, status: :not_found
      end
    rescue Timeout::Error
      Rails.logger.error "Timeout fetching food data for: #{food_name}"
      render json: { error: 'Request timeout' }, status: :request_timeout
    rescue => e
      Rails.logger.error "Error fetching food data: #{e.message}"
      render json: { error: 'Food not found' }, status: :not_found
    end
  end
end
