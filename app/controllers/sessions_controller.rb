class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def new
    redirect_to root_path if logged_in?
  end
  
  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:message] = "Welcome back!"
      session[:message_type] = "success"
      redirect_to root_path
    else
      session[:message] = "Invalid email or password"
      session[:message_type] = "error"
      redirect_to login_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    session[:message] = "You have been logged out"
    session[:message_type] = "success"
    redirect_to login_path
  end
end
