class WelcomeController < ApplicationController
	def index
    if current_user.nil?
      redirect_to login_path
      return
    end

    if current_user.douban_auth_info.nil?
      redirect_to setting_path
      return
    end
    @groups = Group.all
	end
end
