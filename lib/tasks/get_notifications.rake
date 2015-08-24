task :get_notifications => :environment do
	User.all.each do |user|
		spent = user.fb_ads.where(urlcode: "https://viralstyle").map(&:adid).uniq.count
		user.notifications.create(notification_text: "Total ad-spent for Viralstyle yesterday was $#{spent}", notification_unread: 1)
	end
end