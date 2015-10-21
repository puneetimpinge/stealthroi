class RegistrationsController < Devise::RegistrationsController
    #before_filter :validate_payment, :only => 'create'
    # include PayPal::SDK::REST

    def update
	    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
	    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

	    resource_updated = update_resource(resource, account_update_params)
	    yield resource if block_given?
	    if resource_updated
	      if is_flashing_format?
	        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
	          :update_needs_confirmation : :updated
	        set_flash_message :notice, flash_key
	      end
	      sign_in resource_name, resource, bypass: true
	      respond_with resource, location: after_update_path_for(resource)
	    else
	      clean_up_passwords resource
	      # respond_with resource
	      redirect_to :back, alert: resource.errors.messages
	    end
	  end

  #   def create
	 #    build_resource(sign_up_params)

	 #    resource.save
	 #    yield resource if block_given?
	 #    if resource.persisted?
	 #      if resource.active_for_authentication?
	 #        set_flash_message :notice, :signed_up if is_flashing_format?
	 #        sign_up(resource_name, resource)
	 #        respond_with resource, location: after_sign_up_path_for(resource)
	 #      else
	 #        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
	 #        expire_data_after_sign_in!
	 #        respond_with resource, location: after_inactive_sign_up_path_for(resource)
	 #      end
	 #    else
	 #      clean_up_passwords resource
	 #      redirect_to root_url, alert: resource.errors.messages
	 #    end
	 # end

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