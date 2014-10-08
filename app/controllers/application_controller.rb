class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  before_filter :create_user_if_needed

  def current_user
    return @current_user if @current_user
    if session[:current_user].nil?
      return nil
    end
    @current_user = User.find session[:current_user]
  end

  protected
  def create_user_if_needed
    if session[:need_create_new_user]
      redirect_to new_user_path
    end
  end
end
