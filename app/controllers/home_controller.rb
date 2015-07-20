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
  	response = HTTParty.post('http://stealthroi.com/phpscripts/frommidnightdata.php',
      body: params[:parameters] )
  	render :json => { :response => response }.to_json
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
    startHour = Time.at(Time.now.utc + Time.zone_offset('EDT')).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
    lastHour = Time.at(Time.now.utc + Time.zone_offset('EDT') - 1.hour).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
    nowPlusFifteenTimeStamp = Time.at(Time.now.utc + Time.zone_offset('EDT') + 15.days).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")

    response = HTTParty.get("https://viralstyle.com/api/v1/campaigns?end_date_start=#{lastHour}&end_date_end=#{nowPlusFifteenTimeStamp}",
     headers: {"X-Authorization" => "e0cc76b0174030fb70d9a0593b09c34edeb2d5f7"})

    render :json => { :response => "#{response['data'].count}customSplitterUnavailable" }.to_json
  	# response = HTTParty.post('http://stealthroi.com/phpscripts/topCampaignHandlerScript.php',
   #    body: params[:parameters] )
  	# render :json => { :response => response }.to_json
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
