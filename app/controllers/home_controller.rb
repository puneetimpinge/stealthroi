class HomeController < ApplicationController
  require 'httparty'
  def index
    if current_user.nil? 
  	 render :layout => "logout_layout"
    else
      redirect_to "/user/landing"
    end
  end

  def get_viralstyle
  	response = HTTParty.get('http://stealthroi.com/phpscripts/frommidnightdata.php')
  	render :json => { :response => response }
  end

  def  get_teechip
  	response = HTTParty.get('http://stealthroi.com/phpscripts/frommidnightdatateechip.php')
  	render :json => { :response => response }
  end
  	
  def get_represent
  	response = HTTParty.get('http://stealthroi.com/phpscripts/frommidnightdatarepresent.php')
  	render :json => { :response => response }
  end	

  def get_top_campaigns
  	response = HTTParty.get('http://stealthroi.com/phpscripts/topCampaignHandlerScript.php')
  	render :json => { :response => response }
  end

  def get_top_graph
  	response = HTTParty.post("http://stealthroi.com/phpscripts/topGraphHandlerScript.php",
  		body: params[:parameters] )
  	render :json => { :response => response }.to_json
  end

  def get_top_summary
  	response = HTTParty.post("http://stealthroi.com/phpscripts/topSummaryHandlerScript.php",
  		body: params[:parameters] )
  	render :json => { :response => response }.to_json
  end
end
