class HomeController < ApplicationController
  require 'httparty'
  def index
  	render :layout => "logout_layout"
  end

  def get_data
  	response = HTTParty.get('http://stealthroi.com/phpscripts/frommidnightdata.php')
  	render :json => { :response => response }
  end	
end
