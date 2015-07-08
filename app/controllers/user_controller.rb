class UserController < ApplicationController
	before_action :authenticate_user!, :except=> "verify_payment"
	skip_before_filter :verify_authenticity_token, :only=> "verify_payment"
	include PayPal::SDK::REST
	
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

	# private

 #    def user_params
 #      params.require(:user).permit(:fname, :email,:passwordhash)
 #    end
end
