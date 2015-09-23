task :get_fb_ads_data => :environment do
	puts "===============Get Fb Ads rake Start=========================="
	@user = User.where.not("fbadaccount = '' ")

	@user.each do |user|
		begin
			puts "=======#{user.fname}======"
			@graph = Koala::Facebook::API.new("#{user.fbauthtoken.fbtoken}")

			ad_profile = @graph.get_object("/#{user.fbadaccount}/adgroups?fields=id,creative{id,object_story_id, object_story_spec}&limit=2000&adgroup_status=['ACTIVE']", {}, api_version: "v2.3")
			ad_profile.each_with_index do |obj, i|
				objectStoryID = obj["creative"]["object_story_id"]
				id = obj["id"]
				creativeID = obj["creative"]["id"]
				urlCode = ""
				urlDomain = ""

				puts "#{i}/#{ad_profile.count}"
				unless objectStoryID.nil?
					begin
						ad_story = @graph.get_object("/#{objectStoryID}", {}, api_version: "v2.3")
						if ad_story['message'].nil?
							url = nil
						else
							short_url = ad_story['message'].split(/\s+/).find_all { |u| u =~ /^https?:/ }.first
							url = short_url.nil? ? nil : Net::HTTP.get_response(URI.parse("#{short_url}"))['location']
						end
						puts url
						puts "--------------------"
						urlDomain = url.nil? ? "" : url.split(".com/").first
						urlCode = url.nil? ? "" : url.split(".com/").last.split("?").first
						
						if urlDomain.include?("viralstyle")
							puts "===============In viralstyle================"
							spend = @graph.get_object("/#{user.fbadaccount}/reportstats?date_preset=today&data_columns=adgroup_id, spend&filters=[{'field': 'adgroup_id','type': '=','value': #{id}}]", {}, api_version: "v2.3")
							last_rec = FbAd.where(adid: id).last
							if last_rec.nil? || last_rec.tot_spend.nil? || last_rec.tot_spend.empty?
								t_spend = spend
							else
								t_spend = spend - last_rec.tot_spend
							end
							user.fb_ads.create(adid: id, urlcode: urlCode, urldomain: urlDomain, tot_spend: spend, t_spend: t_spend)
							puts ">>>>>>>>>>>>>>>>>>>>>>NEW RECORD<<<<<<<<<<<<<<<<<<<<<<<<<<"
						end	
					rescue Exception => e
						puts "-------------EXCEPTION--------#{user}-------"
						puts e.message
						puts "-------------------------------------"
					end
				end
			end
		rescue Exception => e
			puts "-------------EXCEPTION---------------"
			puts e.message
			puts "-------------------------------------"
		end
	end
	puts "===============Get Fb Ads rake End=========================="
end