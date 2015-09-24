task :get_data => :environment do
	@user = User.where.not("viralstyleapikey = '' ")
	puts "===============Get Viralstyle rake Start=========================="
	@user.each do |user|
		puts "=======#{user.fname}======"
		unless user.viralstyleapikey.empty?
			# time = Time.now.in_time_zone("America/New_York").to_i
			# startTimeStamp = time-5000
			# startOfHour = Time.at(startTimeStamp).in_time_zone("America/New_York").strftime('%Y-%m-%d %H:00:00').in_time_zone("America/New_York").to_i
			# lastOfHour = startOfHour - 3600
			# startHour = Time.at(startOfHour).in_time_zone("America/New_York").strftime('%Y-%m-%d %H:%M:%S').gsub(" ","%20")
			# lastHour = Time.at(startOfHour-3599).in_time_zone("America/New_York").strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
			# nowPlusFifteenTimeStamp=Time.at(startOfHour+1296000).in_time_zone("America/New_York").strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
			startHour = Time.at(Time.now.utc + Time.zone_offset('EDT')).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
		    lastHour = Time.at(Time.now.utc + Time.zone_offset('EDT') - 1.hour).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
			# startHourColumn = "t"+startOfHour.to_s
			# lastHourColumn = "t"+(startOfHour-3600).to_s

			# countColumn = "c"+startOfHour.to_s
			# visitsColumn = "v"+startOfHour.to_s
			# tableTimestamp = ((startOfHour/2000000).floor)*2000000
			# lastTableTimestamp = ((lastOfHour/2000000).floor)*2000000

			# startHour = Time.at(Time.now.utc + Time.zone_offset('EDT')).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
		 #    lastHour = Time.at(Time.now.utc + Time.zone_offset('EDT') - 1.hour).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
		    nowPlusFifteenTimeStamp = Time.at(Time.now.utc + Time.zone_offset('EDT') + 15.days).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")

		    response = HTTParty.get("https://viralstyle.com/api/v1/campaigns?end_date_start=#{lastHour}&end_date_end=#{nowPlusFifteenTimeStamp}",
		     headers: {"X-Authorization" => "#{user.viralstyleapikey}"})

		    unless response['data'].nil?
			    response['data'].each_with_index do |obj,i|
			    	# puts i+1
			      #Campaign.create(obj) if Campaign.where(:id => obj['id']).first.nil?
			      data = HTTParty.get("https://viralstyle.com/api/v1/campaigns/#{obj['id']}/stats?date_start=#{lastHour}&date_end=#{startHour}",
			       headers: {"X-Authorization" => "#{user.viralstyleapikey}"})

			      unless user.campaign_stats.all.where(campaign_id: obj['id']).last.nil?
			      	if (user.campaign_stats.all.where(campaign_id: obj['id']).last.profit > 0 && data['data']['profit'] > 0)
				    	data['data']['profit'] = data['data']['profit'] - user.campaign_stats.all.last.profit
				    end
			      end
			      data['data']['urlcode'] = obj['url']
			      # data['data']['created_at'] = Time.zone.now
			      user.campaign_stats.create(data['data'])

			      # response['data'].delete("utm_stats")
			      #obj.campaign_stats.create(response['data']) if CampaignStat.where(:id => response['data']['campaign_id']).first.nil?
			    end
			end
		end
	end
	puts "===============Get Viralstyle rake End=========================="
end