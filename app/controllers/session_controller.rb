class SessionController < ApplicationController
	def new
    unless session[:current_user].nil?
      redirect_to root_path
    end
    @user = User.new
	end

	def create
    user = User.find_by_email(params[:user][:email])
    if user.password == params[:user][:password]
      session[:current_user] = user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    session[:current_user] = nil
    redirect_to root_path
  end
end
