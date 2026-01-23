class ApplicationController < ActionController::Base
  # Prevent CSRF attacks
  protect_from_forgery with: :exception
  
  # Enable sessions for flash messages
  before_action :set_flash_message
  after_action :clear_flash_message
  
  # Require login for all actions by default
  before_action :require_login
  
  # Authentication helpers
  helper_method :current_user, :logged_in?
  
  private
  
  def set_flash_message
    @message = session[:message]
    @message_type = session[:message_type]
  end
  
  def clear_flash_message
    session[:message] = nil
    session[:message_type] = nil
  end
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_login
    unless logged_in?
      session[:message] = "Please log in to continue"
      session[:message_type] = "error"
      redirect_to login_path
    end
  end
end
