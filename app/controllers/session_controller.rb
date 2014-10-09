class SessionController < ApplicationController
	def new
    unless session[:current_user].nil?
      redirect_to root_path
    end
    @user = User.new
	end

	def create
    authenticated_user = User.authenticate(params[:user][:email], params[:user][:password])
    if authenticated_user
      session[:current_user] = authenticated_user.id
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
