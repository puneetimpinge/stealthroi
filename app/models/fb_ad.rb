class FbAd < ActiveRecord::Base
	belongs_to :user

	scope :today, -> {where("created_at >= ?", Time.zone.now.beginning_of_day)}

 	scope :yesterday, -> {where('created_at >= ? AND created_at =< ?', Time.zone.now.yesterday.beginning_of_day,Time.zone.now.yesterday.end_of_day)}

	scope :last_seven_days, -> {where('created_at >= ? AND created_at =< ?', (Time.zone.now - 7.days).beginning_of_day, (Time.zone.now - 7.days).beginning_of_day + 7.days)}

	scope :this_month, -> {where("created_at >= ?", Time.zone.now.beginning_of_month)}

	scope :last_month, -> {where('created_at >= ? AND created_at =< ?', Time.zone.now.last_month.beginning_of_month,Time.zone.now.last_month.end_of_month)}

	scope :all_time, -> {where("created_at >= ?", Time.zone.now.beginning_of_year)}
end
