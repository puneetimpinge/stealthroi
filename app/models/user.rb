class User < ActiveRecord::Base
  include PayPal::SDK::REST
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable, :omniauth_providers => [:facebook, :google_oauth2]#, :confirmable

  #has_one :payment
  attr_accessor :card_type, :card_number,:cvv,:card_expires_on,:card_name

  attr_accessor :encrypted_password
   before_save :default_values#, :verify_payment

   def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.fname = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def encrypted_password
  	self.passwordhash
  end

  def encrypted_password= (value)
  	self.passwordhash = value
  end

  def default_values
    self.accesslevel ||= 1
    self.viralstyleapikey ||= 'test'
    self.emailverificationcode ||= 'test'
    self.tableprefix ||= 'test'
    self.timezonecode ||= 'test'
  end
  
  def verify_payment
    if self.id.nil?
      @payment = Payment.new({
        :intent => "sale",
        :payer => {
          :payment_method => "credit_card",
          :funding_instruments => [{
            :credit_card => {
              :type => self.card_type,
              :number => self.card_number,
              :expire_month => self.card_expires_on[2],
              :expire_year => self.card_expires_on[1],
              :cvv2 => self.cvv,
              :first_name => self.card_name
              # :last_name => "",
              # :billing_address => {
              #   :line1 => params[:payment][:address], #"52 N Main ST",
              #   :city => params[:payment][:city], #"Johnstown",
              #   :state => params[:payment][:state], #"OH",
              #   :postal_code => params[:payment][:postal_code], #"43210",
              #   :country_code => params[:payment][:country_code] #"US" }
                }}]},
        :transactions => [{
          :amount => {
            :total => "10.00",
            :currency => "USD" },
          :description => "This is the payment transaction description." }]})

      @payment.create
      if @payment.id.nil?
        error = @payment.error
        self.errors.add :payment_status, error
        #return false
        #redirect_to root_url, :alert => error.name+"\n"+error.details.to_s
        #redirect_to :controller=>"home", :action=>"index"
      else
        # params[:payment][:transaction_id] = @payment.id
        # params[:payment][:amount] = 10
        # @data = current_user.build_payment(payment_params)
        # if @data.save
        #   redirect_to payment_index_url, :notice => "Payment Done with payment id #{@payment.id}"
        # else
        #   redirect_to payment_index_url, :alert => "Something went wrong."
        # end
        self.payment_status = @payment.id
      end
    end  
  end

end
