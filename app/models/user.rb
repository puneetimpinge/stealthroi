class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :payment

  attr_accessor :encrypted_password
   before_save :default_values

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
  


end
