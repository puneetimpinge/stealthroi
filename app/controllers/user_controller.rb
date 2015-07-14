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

	private

    def user_params
      params.require(:user).permit(:first_name,:last_name, :phone,:avatar, :fname)
    end
end
