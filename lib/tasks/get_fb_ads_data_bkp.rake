task :get_fb_ads_data1 => :environment do
	@user = User.where(id: 115)

	@user.each do |user|
		@graph = Koala::Facebook::API.new("CAAWFe43jMFABABPZCkvDhl9MCc8bzLYdzE8AFX2sN4qH9M4jkjZASZCfGivzmTmRZCmEAtRokqZAlgaUF2IZBMUncUlKPVHdZBZAWggGvmoXGq0sJBcf4dROvGeNeG6rPxMCU9YKRZCML3KAJ7YKlZAVZB46XCkpCLfZCZBsDyP2B0sF7wJuZCGxIoIgZCa")
		timezone_name = @graph.get_object("act_10150961048316867", {fields: "timezone_name"}, api_version: "v2.3")['timezone_name']

		timeNow = Time.now.in_time_zone("America/New_York").to_i
		startOfHour = Time.at(timeNow).in_time_zone("America/New_York").strftime('%Y-%m-%d %H:00:00').in_time_zone("America/New_York").to_i
		startOfLastHour = startOfHour - 3600
		timeZone = Time.now.in_time_zone(timezone_name)
		beginOfDay = timeZone.beginning_of_day

		if(beginOfDay == startOfHour)
			ad_stats = @graph.get_object("/act_10150961048316867/reportstats?date_preset=yesterday&data_columns=adgroup_id, spend&limit=1000", {}, api_version: "v2.3")
		else
			ad_stats = @graph.get_object("/act_10150961048316867/reportstats?date_preset=today&data_columns=adgroup_id, spend&limit=1000", {}, api_version: "v2.3")
		end

		ad_profile = @graph.get_object("/act_10150961048316867/adgroups?fields=id,creative{id,object_story_id, object_story_spec}&limit=1000&adgroup_status=['ACTIVE']", {}, api_version: "v2.3")
#=========
		# record = ""
		# ad_profile.each do |a| 
		# 	if a['id'] == "6027095447028"
		# 		record = a 
		# 	end
		# end 
		# id = record['id']
		# objectStoryID = record["creative"]["object_story_id"]
		# ad_story = @graph.get_object("/#{objectStoryID}", {}, api_version: "v2.3")
		# short_url = ad_story['message'].split(/\s+/).find_all { |u| u =~ /^https?:/ }.first
		# url = Net::HTTP.get_response(URI.parse("#{short_url}"))['location']
		
		# urlDomain = url.split(".com/").first
		# urlCode = url.split(".com/").last
		# puts "id: #{id}";
		# puts "urlcode: #{urlCode}";
		# puts "urldomain: #{urlDomain}";
		# user.fb_ads.create(adid: id, urlcode: urlCode, urldomain: urlDomain)
#============
		arr1 = [];arr2=[];
		unless FbAd.all.empty?
			ad_profile.each{|a| arr1 << a['id'].to_i}
			FbAd.all.each{|a| arr2 << a.adid.to_i}
			diff = arr2 - arr1
		end
		ad_profile.each_with_index do |obj, i|
			objectStoryID = obj["creative"]["object_story_id"]
			id = obj["id"]
			creativeID = obj["creative"]["id"]
			urlCode = ""
			urlDomain = ""

			puts "#{i}/#{ad_profile.count}"
			puts id
			# if user.fb_ads.all.where(adid: id).empty?
				# user.fb_ads.create(adid: id, urlcode: urlCode, urldomain: urlDomain)
			# else
				#=============
				if FbAd.where(adid: id).empty?
					unless objectStoryID.nil?
						ad_story = @graph.get_object("/#{objectStoryID}", {}, api_version: "v2.3")
						if ad_story['message'].nil?
							url = nil
						else
							short_url = ad_story['message'].split(/\s+/).find_all { |u| u =~ /^https?:/ }.first
							url = Net::HTTP.get_response(URI.parse("#{short_url}"))['location']
						end
						
						urlDomain = url.nil? ? "" : url.split(".com/").first
						urlCode = url.nil? ? "" : url.split(".com/").last.split("?").first
						#=============

						# user.fb_ads.all.where(adid: id).update_all(urlcode: urlCode, urldomain: urlDomain)
						user.fb_ads.create(adid: id, urlcode: urlCode, urldomain: urlDomain, created_at: Time.zone.now) if urlDomain.include?("viralstyle")
					end
				else
					record = FbAd.where(adid: id).first
					id = record.adid
					urlCode = record.urlcode
					urlDomain = record.urldomain
					user.fb_ads.create(adid: id, urlcode: urlCode, urldomain: urlDomain, created_at: Time.zone.now) if urlDomain.include?("viralstyle")
				end
			# end
			# unless diff.nil?
			# 	diff.each do |obj|
			# 		record = FbAd.where(adid: obj.to_s).first
			# 		id = record.adid
			# 		urlCode = record.urlcode
			# 		urlDomain = record.urldomain
			# 		user.fb_ads.create(adid: id, urlcode: urlCode, urldomain: urlDomain)
			# 	end
			# end
		end
		if !diff.nil? && !diff.empty?
			diff.uniq.each do |obj|
				puts "====================diff===================="
				puts obj
				puts "============================================"
				record = FbAd.where(adid: obj.to_s).first
				id = record.adid
				urlCode = record.urlcode
				urlDomain = record.urldomain
				user.fb_ads.create(adid: id, urlcode: urlCode, urldomain: urlDomain, created_at: Time.zone.now) if urlDomain.include?("viralstyle")
			end
		end

		ad_stats.each_with_index do |obj, i|
			begin
				id = obj["adgroup_id"]
				spend = obj["spend"]
				tot_spend = spend
				# tot_spend = (i==0 ? spend : spend - ad_stats[i-1]["spend"])
				# last_spend = user.fb_ads.all.where(adid: id).last(2).first.tot_spend
				if user.fb_ads.all.where(adid: id).empty?
					t_spend = 0
				else
					t_spend = (user.fb_ads.all.where(adid: id).count==1 ? spend : spend - user.fb_ads.all.where(adid: id).last(2).first.tot_spend.to_f)
				end
				# t_spend = (i==0 ? spend : spend - (user.fb_ads.all.where(adid: id).empty? ? 0 : user.fb_ads.all.where(adid: id).last(2).first.t_spend.to_f))
				puts id
				puts "t_spend: #{t_spend}, tot_spend: #{tot_spend}"
				# user.fb_ads.all.where(adid: id).update_all(t_spend: t_spend, tot_spend: tot_spend)
				user.fb_ads.all.where(adid: id).last.update_attributes(t_spend: t_spend, tot_spend: tot_spend) unless user.fb_ads.all.where(adid: id).empty?
			rescue
				puts "===============Error================"
			end
		end
	end
end