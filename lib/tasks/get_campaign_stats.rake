task :get_campaign_stats => :environment do
	Campaign.all.each do |obj|
      response = HTTParty.get("https://viralstyle.com/api/v1/campaigns/#{obj.id}/stats?with_utm=1",
       headers: {"X-Authorization" => "e0cc76b0174030fb70d9a0593b09c34edeb2d5f7"})

      response['data'].delete("utm_stats")
      obj.campaign_stats.create(response['data']) if CampaignStat.where(:id => response['data']['campaign_id']).first.nil?
    end
end