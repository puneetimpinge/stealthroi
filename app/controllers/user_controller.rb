class UserController < ApplicationController
	before_action :authenticate_user!
	
	def landing
		
	end

	def dashboard

	end
	
	def setting

	end

	def ads_manager

	end

	def reports

	end

	def keywords

	end

	def login

	end

	# def create
	# 	params[:user][:accesslevel] = 1
	# 	user = User.find_by_email(params[:email])
	# 	if user.nil?
	# 		user = User.new(user_params)
	# 		user.save
	# 	else
	# 		redirect_to root_url
	# 	end
	# end		

	# private

 #    def user_params
 #      params.require(:user).permit(:fname, :email,:passwordhash)
 #    end
end
