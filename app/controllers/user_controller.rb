class UserController < ApplicationController
	before_action :authenticate_user!, :except=> ["verify_payment","verify_username"]
	skip_before_filter :verify_authenticity_token, :only=> "verify_payment"
	include PayPal::SDK::REST
	
	def landing
		
	end

	def dashboard

	end
	
	def setting
		@user = current_user
	end

	def ads_manager

	end

	def reports

	end

	def keywords

	end

	def login

	end

	def update
		if params.has_key?("user")
			params[:user].delete("email") if params[:user].has_key?("email")
			if current_user.update(user_params)
				redirect_to :back, notice: "Profile Updated Successfully."
			else
				redirect_to root_url, alert: "Something went wrong"
			end
		else
			redirect_to root_url
		end
	end

	def show
		render :nothing
	end

	def verify_payment
		begin
			@payment = Payment.new({
		        :intent => "sale",
		        :payer => {
		          :payment_method => "credit_card",
		          :funding_instruments => [{
		            :credit_card => {
		              :type => params[:card_type],
		              :number => params[:card_number],
		              :expire_month => params[:card_month],
		              :expire_year => params[:card_year],
		              :cvv2 => params[:cvv],
		              :first_name => params[:card_name]
		                }}]
		        },
		        :transactions => [{
		            :amount => {
		              :total => "10.00",
		              :currency => "USD" },
		            :description => "This is the payment transaction description." 
		        }]
		    })
			@payment.create
				if @payment.id.nil?
				# error = @payment.error
				# binding.pry
				render :json => {:status => false, :message => @payment.error.details}
				# redirect_to root_url, :alert => error.name+"\n"+error.details.to_s
			else
				render :json => {:status => true, :message => @payment.id}
				# params[:payment_status] = @payment.id
			end
		rescue Exception => e
			render :json => {:status => false, :message => e.message}
		end
	end

	# def create
	# 	params[:accesslevel] = 1
	# 	user = User.find_by_email(params[:email])
	# 	if user.nil?
	# 		user = User.new(user_params)
	# 		user.save
	# 	else
	# 		redirect_to root_url
	# 	end
	# end		

	def verify_username
		@user = User.where(fname: params[:username]).first
		render :json => {:status => (@user.nil? ? true : false)}
	end

	def connect_facebook
		@oauth = Koala::Facebook::OAuth.new(ENV['facebook_app_id'], ENV['facebook_secret'], "#{request.protocol}#{request.host}/user/get_fb_token/")
    	redirect_to @oauth.url_for_oauth_code(:permissions => "manage_pages ,email,publish_actions, ads_read, ads_management")
	end

	def get_fb_token
		if params[:code]
	      @oauth = Koala::Facebook::OAuth.new(ENV['facebook_app_id'], ENV['facebook_secret'], "#{request.protocol}#{request.host}/get_fb_token/")
	      session[:access_token] = @oauth.get_access_token(params[:code])
	      # @api = Koala::Facebook::API.new(session[:access_token])
	      # current_user.update_attributes(:fb_token=>session[:access_token])
	      binding.pry
	      flash[:notice] = "Connected with Facebook"
	      redirect_to "/"
	    end 
	end

	private

    def user_params
      params.require(:user).permit(:first_name,:last_name, :phone,:avatar, :fname, :viralstyleapikey)
    end
end
