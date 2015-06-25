class RegistrationsController < Devise::RegistrationsController
    #before_filter :validate_payment, :only => 'create'
    include PayPal::SDK::REST

private
    def validate_payment
    	user = User.new(:fname=>params[:user][:fname],:email=>params[:user][:email],:password=>params[:user][:password],:password_confirmation=>params[:user][:password_confirmation])
    	if user.validate
	    	@payment = Payment.new({
	        :intent => "sale",
	        :payer => {
	          :payment_method => "credit_card",
	          :funding_instruments => [{
	            :credit_card => {
	              :type => params[:user][:card_type],
	              :number => params[:user][:card_number],
	              :expire_month => params[:user]["card_expires_on(2i)"],
	              :expire_year => params[:user]["card_expires_on(1i)"],
	              :cvv2 => params[:user][:cvv],
	              :first_name => params[:user][:card_name]
	                }}]},
	          :transactions => [{
	            :amount => {
	              :total => "10.00",
	              :currency => "USD" },
	            :description => "This is the payment transaction description." }]
	        })

			@payment.create
				if @payment.id.nil?
				error = @payment.error
				redirect_to root_url, :alert => error.name+"\n"+error.details.to_s
			else
				params[:user][:payment_status] = @payment.id
			end
	    else
	    	error = user.errors.messages
	    	redirect_to root_url, :alert => error
	    end
    end
end