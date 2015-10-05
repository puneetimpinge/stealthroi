task :get_notifications => :environment do
	puts "===============Notifications rake Start=========================="
	User.all.each do |user|
		spent = user.fb_ads.yesterday.where(urldomain: "https://viralstyle").map(&:t_spend).sum
		user.notifications.create(notification_text: "Total ad-spent for Viralstyle yesterday was $#{spent}", notification_unread: 1)
	end
	puts "===============Notifications rake End=========================="
end