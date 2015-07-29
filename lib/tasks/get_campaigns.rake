task :get_campaigns => :environment do
	startHour = Time.at(Time.now.utc + Time.zone_offset('EDT')).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
    lastHour = Time.at(Time.now.utc + Time.zone_offset('EDT') - 1.hour).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")
    nowPlusFifteenTimeStamp = Time.at(Time.now.utc + Time.zone_offset('EDT') + 15.days).strftime('%Y-%m-%d %H:00:00').gsub(" ","%20")

    response = HTTParty.get("https://viralstyle.com/api/v1/campaigns?end_date_start=#{lastHour}&end_date_end=#{nowPlusFifteenTimeStamp}",
     headers: {"X-Authorization" => "e0cc76b0174030fb70d9a0593b09c34edeb2d5f7"})

    response['data'].each do |obj|
      Campaign.create(obj) if Campaign.where(:id => obj['id']).first.nil?
    end
end