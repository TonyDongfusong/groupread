require 'douban_client'

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

  def edit
    @user = current_user
  end

  def oauth_callback
    auth_rsp = DoubanClient.token_auth(params[:code])
    @user = current_user
    unless @user.douban_auth_info.nil?
      @user.douban_auth_info.update_attributes(auth_rsp)
    else
      @user.douban_auth_info = DoubanAuthInfo.create(auth_rsp)
      @user.save
    end
    flash[:authed] = true
    redirect_to setting_path
  end
end
