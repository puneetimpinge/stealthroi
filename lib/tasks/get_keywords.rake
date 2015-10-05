task :get_keywords => :environment do
	puts "===============Get Keyword rake Start=========================="
	@user = User.where.not("fbadaccount = '' ")
	@user.all.each do |user|
		puts "=======#{user.fname}======"
		@graph = Koala::Facebook::API.new("#{user.fbauthtoken.fbtoken}")
		ads = user.fb_ads.all
		unless ads.empty?
			ads.each do |obj|
				
					data = @graph.get_object("/#{obj.adid}/insights?fields=ctr,cpc,spend,cpm,adgroup_name,campaign_id", {}, api_version: "v2.3").first
					ctr = data['ctr']
					cpc = data['cpc']
					spend = data['spend']
					cpm = data['cpm']
					target_domain = obj.urldomain
					target_page = obj.urlcode
					name = data['adgroup_name']
					campaign_id = data['campaign_id']
					group_id = obj.adid

					a=@graph.get_object("/#{obj.adid}/conversions?fields=values", {}, api_version: "v2.3")
					conversions = 0
					a['values'].each do |b|
						b['conversions'].each do |c|
							if c['action_type'] == 'offsite_conversion.checkout'
								conversions = c['post_click_28d']
								cpc = spend/conversions
							end
						end
					end
				if AdKeyword.where(group_id: "#{obj.adid}").empty?
					rec = user.ad_keywords.new(group_id: group_id, campaign_id: campaign_id, target_domain: target_domain, target_page: target_page,
						name: name, ctr: ctr, cpm: cpm, cpc: cpc, totalspend: spend,conversions: conversions)
					rec.save
					puts ">>>>>>>>>>>>>>>>>>>>>>NEW RECORD<<<<<<<<<<<<<<<<<<<<<<<<<<"
				else
					AdKeyword.where(group_id: "#{obj.adid}").last.update_attributes(group_id: group_id, campaign_id: campaign_id, target_domain: target_domain, target_page: target_page,
						name: name, ctr: ctr, cpm: cpm, cpc: cpc, totalspend: spend,conversions: conversions)
				end
			end
		end
	end
	puts "===============Get Keyword rake End=========================="
end