task :shopify_stats => :environment do
	# t=Time.zone.now - 1.hour
	@user = User.where.not("shopify = '' ")
	puts "===============Get Shopify rake Start=========================="
	@user.each do |user|
		puts "=======#{user.fname}======"
		if !user.shopify.empty? && !user.shopify_password.empty?
			zone = ActiveSupport::TimeZone.new("#{user.timezone}")
			t=Time.now.in_time_zone(zone) - 1.hour
			# t1 = (Time.now.in_time_zone(zone).at_beginning_of_hour()-1.hour).to_s
			t1 = (t.at_beginning_of_hour()).to_s
			startHour = t1.split[0]+"T"+t1.split[1]+t1.split[2]
			# t2 = (Time.now.in_time_zone(zone).at_beginning_of_hour()).to_s
			t2 = (t.at_end_of_hour()).to_s
			lastHour = t2.split[0]+"T"+t2.split[1]+t2.split[2]

		    response = HTTParty.get("https://#{user.shopify}:#{user.shopify_password}@social-media-reach.myshopify.com/admin/orders.json?created_at_min=#{startHour}&created_at_max=#{lastHour}&fields=created_at,id,total-price&limit=250")

		    price = 0
		    unless response['orders'].nil?
			    response['orders'].each_with_index do |obj,i|
			      price = price + obj['total_price'].to_f
			      puts "***** #{obj} *****"
			      puts "#{t}"
			      # if user.shopify_stats.all.where(order: obj['id']).last.nil?
			      # 	user.shopify_stats.create(order: obj['id'], price: obj['total_price'], created_time: obj['created_at'])	
			      # end
			    end
			    user.shopify_stats.create(order: response['orders'].count, price: price, created_at: t.at_end_of_hour() )
			end
		end
	end
	puts "===============Get Shopify rake End=========================="
end