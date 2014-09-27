class SessionController < ApplicationController
	def new
    if session[:logged_in]
      redirect_to root_path
    end
    @user = User.new
	end

	def create
    user_param = params[:user]
    p user_param
    if User.find_by_email(user_param[:email]).password == user_param[:password]
      session[:logged_in] = true
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    session[:logged_in] = false
    redirect_to root_path
  end
end
