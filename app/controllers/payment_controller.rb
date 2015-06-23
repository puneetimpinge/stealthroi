class PaymentController < ApplicationController
	before_action :authenticate_user!
	include PayPal::SDK::REST

	def index
		@payment = current_user.build_payment if current_user.payment.nil?
	end

	# def new
	# 	#if current_user.payment.nil?
	# 		@payment = current_user.build_payment
	# 	# else
	# 	# 	redirect_to root_url, alert: "Payment is already done"
	# 	# end
	# end

	def create
		@payment = Payment.new({
		  :intent => "sale",
		  :payer => {
		    :payment_method => "credit_card",
		    :funding_instruments => [{
		      :credit_card => {
		      	:type => params[:payment][:card_type], #"visa",
		        :number => params[:payment][:card_number], #"4242424242424242",
		        :expire_month => params[:payment]["card_expires_on(2i)"], #"1",
		        :expire_year => params[:payment]["card_expires_on(1i)"], #"2018",
		        :cvv2 => params[:payment][:cvv2], #"874",
		        :first_name => params[:payment][:first_name], #"Joe",
		        :last_name => params[:payment][:last_name], #"Shopper",
		        :billing_address => {
		          :line1 => params[:payment][:address], #"52 N Main ST",
		          :city => params[:payment][:city], #"Johnstown",
		          :state => params[:payment][:state], #"OH",
		          :postal_code => params[:payment][:postal_code], #"43210",
		          :country_code => params[:payment][:country_code] #"US" 
		          }}}]},
		  :transactions => [{
		    :amount => {
		      :total => "10.00",
		      :currency => "USD" },
		    :description => "This is the payment transaction description." }]})

		@payment.create
		if @payment.id.nil?
			error = @payment.error
			redirect_to payment_index_url, :alert => error.name+"\n"+error.details.to_s
		else
			params[:payment][:transaction_id] = @payment.id
			params[:payment][:amount] = 10
			@data = current_user.build_payment(payment_params)
			if @data.save
				redirect_to payment_index_url, :notice => "Payment Done with payment id #{@payment.id}"
			else
				redirect_to payment_index_url, :alert => "Something went wrong."
			end
		end
	end

	def destroy
		if current_user.payment.id == params[:id].to_i
			current_user.payment.delete
			redirect_to root_url
		else
			redirect_to root_url, alert: "Something went wrong."
		end
	end

	private

    def payment_params
      params.require(:payment).permit(:first_name, :last_name,:amount,:transaction_id,:user_id)
    end
	
end