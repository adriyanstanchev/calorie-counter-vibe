class FoodsController < ApplicationController
  # GET / - Show all foods and form
  def index
    @foods = Food.order(created_at: :desc)
    @total_calories = Food.total_calories_today
  end
  
  # POST /foods - Create a new food entry
  def create
    name = params[:name]
    calories = params[:calories].to_i
    
    if name.present? && calories > 0
      Food.create(name: name, calories: calories)
      session[:message] = "Added #{name} (#{calories} calories)!"
      session[:message_type] = "success"
    else
      session[:message] = "Please enter both name and calories!"
      session[:message_type] = "error"
    end
    
    redirect_to root_path
  end
  
  # DELETE /foods/:id - Delete a food entry
  def destroy
    food = Food.find(params[:id])
    food.destroy
    session[:message] = "Food entry deleted!"
    session[:message_type] = "delete"
    redirect_to root_path
  end
  
  # GET /search_foods - API endpoint to search common foods
  def search
    query = params[:q] || ''
    foods = CommonFood.search(query)
    render json: foods
  end
end
