require 'douban_client'

class UsersController < ApplicationController

  skip_before_filter :create_user_if_needed, only: [:new, :create]

  def new
    unless session[:need_create_new_user]
      redirect_to root_path
    end
    @user = User.new
  end

  def create
    user = User.new(params[:user].permit(:email, :password))
    if !user.save
      render :new
      return
    end
    user.douban_auth_info = DoubanAuthInfo.find (session[:need_create_new_user]["auth_info_id"])
    user.save

    session[:current_user] = user.id
    session[:need_create_new_user] = nil

    redirect_to root_path
  end

  def edit
    @user = current_user
  end

  def oauth_callback
    auth_rsp = DoubanClient.token_auth(params[:code])
    if auth_rsp[:status] != 200
      @fails_rsp = auth_rsp
      render "oauth_fail"
      return
    end

    douban_auth_info = DoubanAuthInfo.find_or_create_by(auth_rsp[:auth_info])
    if douban_auth_info.user.nil?
      session[:need_create_new_user] = {auth_info_id: douban_auth_info.id}
      redirect_to new_user_path
    else
      session[:current_user] = douban_auth_info.user.id
      redirect_to root_path
    end
  end
end
