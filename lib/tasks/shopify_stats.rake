task :shopify_stats => :environment do
	@user = User.where(email: "dev@stealthroi.com")#User.where.not("shopify = '' ")
	puts "===============Get Shopify rake Start=========================="
	@user.each do |user|
		puts "=======#{user.fname}======"
		# unless user.shopify.empty?
			zone = ActiveSupport::TimeZone.new("#{user.timezone}")
			t1 = (Time.now.in_time_zone(zone).at_beginning_of_hour()-1.hour).to_s
			startHour = t1.split[0]+"T"+t1.split[1]+t1.split[2]
			t2 = (Time.now.in_time_zone(zone).at_beginning_of_hour()).to_s
			lastHour = t2.split[0]+"T"+t2.split[1]+t2.split[2]

		    response = HTTParty.get("https://ec953b111fc719ed2ebca789bc9e0586:dbbe043b621fe7ccca4e3d93a3027d68@social-media-reach.myshopify.com/admin/orders.json?created_at_min=#{startHour}&created_at_max=#{lastHour}&fields=created_at,id,total-price")

		    unless response['orders'].nil?
			    response['orders'].each_with_index do |obj,i|
			      puts "#{i}"
			      if user.shopify_stats.all.where(order: obj['id']).last.nil?
			      	user.shopify_stats.create(order: obj['id'], price: obj['total_price'], created_time: obj['created_at'])	
			      end
			    end
			end
		# end
	end
	puts "===============Get Shopify rake End=========================="
end