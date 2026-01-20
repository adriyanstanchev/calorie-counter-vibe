class ApplicationController < ActionController::Base
  # Prevent CSRF attacks
  protect_from_forgery with: :exception
  
  # Enable sessions for flash messages
  before_action :set_flash_message
  after_action :clear_flash_message
  
  private
  
  def set_flash_message
    @message = session[:message]
    @message_type = session[:message_type]
  end
  
  def clear_flash_message
    session[:message] = nil
    session[:message_type] = nil
  end
end
