class HomeController < ApplicationController
  require 'httparty'
  def index
    if current_user.nil? 
  	 render :layout => "logout_layout"
    else
      # get_campaigns_data()
      redirect_to "/user/landing"
    end
  end

  def get_viralstyle
    startHour = Time.at(Time.now.utc + Time.zone_offset('EDT')).strftime('%Y-%m-%d %H:00:00')#.gsub(" ","%20")
    lastHour = Time.at(Time.now.utc + Time.zone_offset('EDT') - 1.hour).strftime('%Y-%m-%d %H:00:00')#.gsub(" ","%20")
    nowPlusFifteenTimeStamp = Time.at(Time.now.utc + Time.zone_offset('EDT') + 15.days).strftime('%Y-%m-%d %H:00:00')#.gsub(" ","%20")
    # @data = current_user.campaign_stats.send(params["graphtimeindex"].downcase.gsub(" ","_"))
    @data = current_user.campaign_stats.where('created_at > ? AND created_at < ?', lastHour, nowPlusFifteenTimeStamp)
    render :json => {:status => false} if @data.empty?
    # startHour = Time.at(Time.now.utc + Time.zone_offset('EDT')).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
    # lastHour = Time.at(Time.now.utc + Time.zone_offset('EDT') - 1.hour).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
    # nowPlusFifteenTimeStamp = Time.at(Time.now.utc + Time.zone_offset('EDT') + 15.days).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")

    # @response = HTTParty.get("https://viralstyle.com/api/v1/campaigns?end_date_start=#{lastHour}&end_date_end=#{nowPlusFifteenTimeStamp}",
    #  headers: {"X-Authorization" => "e0cc76b0174030fb70d9a0593b09c34edeb2d5f7"})

    # @data = []
    # @response['data'].each_with_index do |obj,i|
    #   puts "get_viralstyle"
    #   puts i+1
    #   @data << HTTParty.get("https://viralstyle.com/api/v1/campaigns/#{obj['id']}/stats?date_start=#{lastHour}&date_end=#{startHour}",
    #    headers: {"X-Authorization" => "e0cc76b0174030fb70d9a0593b09c34edeb2d5f7"})
    #   sleep 3
    # end

  	# response = HTTParty.post('http://stealthroi.com/phpscripts/frommidnightdata.php',
   #    body: params[:parameters] )
  	# render :json => { :response => response }.to_json
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
    begin
      if current_user.viralstyleapikey.empty?
        campaign_count = 0
      else
        startHour = Time.at(Time.now.utc + Time.zone_offset('EDT')).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
        lastHour = Time.at(Time.now.utc + Time.zone_offset('EDT') - 1.hour).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
        nowPlusFifteenTimeStamp = Time.at(Time.now.utc + Time.zone_offset('EDT') + 15.days).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")

        response = HTTParty.get("https://viralstyle.com/api/v1/campaigns?end_date_start=#{lastHour}&end_date_end=#{nowPlusFifteenTimeStamp}",
         headers: {"X-Authorization" => "#{current_user.viralstyleapikey}"})
        campaign_count = response['data'].count
      end
    rescue Exception => e
      campaign_count = 0
    end
    render :json => { :response => "#{campaign_count}customSplitterUnavailable" }.to_json

    # campaign_count = CampaignStat.today.map(&:campaign_id).uniq.count
    # render :json => { :response => "#{campaign_count}customSplitterUnavailable" }.to_json    
  	# response = HTTParty.post('http://stealthroi.com/phpscripts/topCampaignHandlerScript.php',
   #    body: params[:parameters] )
  	# render :json => { :response => response }.to_json
  end

  def get_top_graph
  	# response = HTTParty.post("http://stealthroi.com/phpscripts/topGraphHandlerScript.php",
  	# 	body: params[:parameters] )
  	# render :json => { :response => response }.to_json
    h=[]
    if params["graphtimeindex"].downcase.gsub(" ","_") == "today"
      puts "========today========="
      start_time = Time.zone.now.beginning_of_day
      end_time = Time.zone.now.end_of_day + 1.hour
      step = 1.hour
      time_inc = 1.hour
      time_format = '%l:00 %p'
    elsif params["graphtimeindex"].downcase.gsub(" ","_") == "yesterday"
      puts "=======yesterday========="
      start_time = Time.zone.now.yesterday.beginning_of_day
      end_time = Time.zone.now.yesterday.end_of_day + 1.hour
      step = 1.hour
      time_inc = 1.hour
      time_format = '%l:00 %p'
    elsif params["graphtimeindex"].downcase.gsub(" ","_") == "last_seven_days"
      puts "=======last_seven_days========="
      start_time = (Time.zone.now - 7.days).beginning_of_day
      end_time = (Time.zone.now - 7.days).beginning_of_day + 7.days - 1.second
      step = 1.days
      time_inc = 1.days
      time_format = '%d %b'
    elsif params["graphtimeindex"].downcase.gsub(" ","_") == "this_month"
      puts "=======this_month========="
      start_time = Time.zone.now.beginning_of_month
      end_time = Time.zone.now.end_of_month
      step = 1.days
      time_inc = 1.days
      time_format = '%d %b'
    elsif params["graphtimeindex"].downcase.gsub(" ","_") == "last_month"
      puts "=======last_month========="
      start_time = Time.zone.now.last_month.beginning_of_month
      end_time = Time.zone.now.last_month.end_of_month
      step = 1.days
      time_inc = 1.days
      time_format = '%d %b'
    elsif params["graphtimeindex"].downcase.gsub(" ","_") == "all_time"
      puts "=======all_time========="
      start_time = Time.zone.now.beginning_of_year
      end_time = Time.zone.now.end_of_year
      step = 31.days
      time_inc = 1.month
      time_format = '%b'
    end

    (start_time.to_i..end_time.to_i).step(step).each_with_index do |a,i|
        data = CampaignStat.where('created_at > ? AND created_at < ?', Time.zone.at(a),Time.zone.at(a)+time_inc)
        earned = data.map(&:profit).sum.to_f.to_s
        order = data.map(&:current_order_count).sum
        h[i] = {a: "0.00",b: earned, c: order, time: Time.zone.at(a).strftime(time_format)}
    end
      
    render :json => { :response => h }.to_json
  end

  def get_top_summary
    # startHour = Time.at(Time.now.utc + Time.zone_offset('EDT')).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
    # lastHour = Time.at(Time.now.utc + Time.zone_offset('EDT') - 1.hour).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
    # nowPlusFifteenTimeStamp = Time.at(Time.now.utc + Time.zone_offset('EDT') + 15.days).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")

    # totalEarned = 0
    # totalSpent = 0
    # totalProfit = 0
    # totalROI = 0
    # totalOrders = 0
    # response = HTTParty.get("https://viralstyle.com/api/v1/campaigns?end_date_start=#{lastHour}&end_date_end=#{nowPlusFifteenTimeStamp}",
    #  headers: {"X-Authorization" => "e0cc76b0174030fb70d9a0593b09c34edeb2d5f7"})

    # response['data'].each_with_index do |obj,i|
    #   puts "get_top_summary"
    #   puts i+1
    #   data = HTTParty.get("https://viralstyle.com/api/v1/campaigns/#{obj['id']}/stats?date_start=#{lastHour}&date_end=#{startHour}",
    #    headers: {"X-Authorization" => "e0cc76b0174030fb70d9a0593b09c34edeb2d5f7"})
    #   sleep 3
    #   totalEarned = totalEarned + data['data']['profit']
    #   totalOrders = totalOrders + data['data']['current_order_count']
    # end

    # render :json => { :response => "#{totalEarned}customSplitter#{totalSpent}customSplitter#{totalProfit}customSplitter#{totalROI}customSplitter#{totalOrders}" }.to_json
    @data = current_user.campaign_stats.send(params["parameters"]["graphtimeindex"].downcase.gsub(" ","_"))
    totalEarned = @data.map(&:profit).sum
    totalSpent = 0
    totalProfit = 0
    totalROI = 0
    totalOrders = @data.map(&:current_order_count).sum
 
    render :json => { :response => "#{totalEarned}customSplitter#{totalSpent}customSplitter#{totalProfit}customSplitter#{totalROI}customSplitter#{totalOrders}" }.to_json
  	# response = HTTParty.post("http://stealthroi.com/phpscripts/topSummaryHandlerScript.php",
  	# 	body: params[:parameters] )
  	# render :json => { :response => response }.to_json
  end

  # def get_campaigns_data
  #   # binding.pry
  #   # startHour = Time.at(Time.now.utc + Time.zone_offset('EDT')).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
  #   # lastHour = Time.at(Time.now.utc + Time.zone_offset('EDT') - 1.hour).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
  #   # nowPlusFifteenTimeStamp = Time.at(Time.now.utc + Time.zone_offset('EDT') + 15.days).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
  #   Campaign.all.each do |obj|

  #     response = HTTParty.get("https://viralstyle.com/api/v1/campaigns/#{obj.id}/stats?with_utm=1",
  #      headers: {"X-Authorization" => "e0cc76b0174030fb70d9a0593b09c34edeb2d5f7"})

  #     response['data'].delete("utm_stats")
  #     obj.campaign_stats.create(response['data']) if CampaignStat.where(:id => response['data']['campaign_id']).first.nil?
  #   end
  # end

  def get_campaign_details
    response = HTTParty.post("http://stealthroi.com/phpscripts/campaignDetails.php",
      body: params[:parameters] )
    render :json => { :response => response }.to_json
  end
end
