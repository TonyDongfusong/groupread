class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(params[:user].permit(:email, :password))
    if !user.save
      render :new
      return
    end
  end
end
