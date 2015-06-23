class Payment < ActiveRecord::Base
  belongs_to :user

  attr_accessor :card_type, :card_number,:address,:city,:state,:postal_code,:country_code,:cvv2,:card_expires_on
end
