task :get_records => :environment do
	user = User.find(116)
	# User.all.each do |user|
		time = (Time.now.in_time_zone("America/New_York") - 11.months)
		while time < Time.now.in_time_zone("America/New_York")
			puts time
			# unless user.viralstyleapikey.empty?
				start_time = time.strftime('%Y-%m-%d %H:%M:%S').gsub(" ","%20")
				end_time =  (time+1.hour).strftime('%Y-%m-%d %H:%M:%S').gsub(" ","%20")
				time = time + 1.hour

			    response = HTTParty.get("https://viralstyle.com/api/v1/campaigns?end_date_start=#{start_time}&end_date_end=#{end_time}",
			     headers: {"X-Authorization" => "e0cc76b0174030fb70d9a0593b09c34edeb2d5f7"})

			    unless response['data'].nil?
				    response['data'].each_with_index do |obj,i|
				    	puts i+1
				      #Campaign.create(obj) if Campaign.where(:id => obj['id']).first.nil?
				      data = HTTParty.get("https://viralstyle.com/api/v1/campaigns/#{obj['id']}/stats?date_start=#{start_time}&date_end=#{end_time}",
				       headers: {"X-Authorization" => "e0cc76b0174030fb70d9a0593b09c34edeb2d5f7"})

				      unless user.campaign_stats.all.last.nil?
				      	if user.campaign_stats.all.last.profit > 0
					    	data['data']['profit'] = data['data']['profit'] - user.campaign_stats.all.last.profit
					    end
				      end
				      data['data']['urlcode'] = obj['url']
				      user.campaign_stats.create(data['data'])

				    end
				end
			# end
		end
	# end
end