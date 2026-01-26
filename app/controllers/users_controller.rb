class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      session[:show_profile_modal] = true
      session[:message] = "Account created successfully! Welcome!"
      session[:message_type] = "success"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @user = current_user
  end
  
  def update
    @user = current_user
    
    if @user.update(profile_params)
      session[:message] = "Profile updated successfully!"
      session[:message_type] = "success"
      redirect_to profile_path
    else
      render :show, status: :unprocessable_entity
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, 
                                  :height, :weight, :age, :gender, :activity_level, :goal)
  end
  
  def profile_params
    params.require(:user).permit(:height, :weight, :age, :gender, :activity_level, :goal)
  end
end
