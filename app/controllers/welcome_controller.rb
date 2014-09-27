class WelcomeController < ApplicationController
	def index
    unless session[:logged_in]
      redirect_to login_path
    end
	end
end
