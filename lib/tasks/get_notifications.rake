task :get_notifications => :environment do
	user = User.find(115)
	# User.all.each do |user|
		spent = user.fb_ads.where(urlcode: "https://viralstyle").map(&:adid).uniq.count
		user.notifications.create(notification_text: "Total ad-spent for Viralstyle yesterday was $#{spent}", notification_unread: 1, created_at: Time.zone.now)
	# end
end