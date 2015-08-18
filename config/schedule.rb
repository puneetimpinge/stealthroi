# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :environment, "development"
env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']
# env :PATH, ENV['PATH']
# require File.expand_path('../application', __FILE__)
set :output, "log/cron_log.log"
# set :bundle_command, "/home/ritika/.rvm/gems/ruby-2.1.2/bin/bundle-audit"
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
every 2.minutes do
	puts "hi"
  command 'echo "hello"'
end

# every 2.minutes do
every :hour do
	# rake "get_data"
  command 'cd /home/ritika/RubymineProjects/Puneet/stealth_app && bundle install && bin/rake get_data'
  command 'cd /home/ritika/RubymineProjects/Puneet/stealth_app && bundle install && bin/rake get_fb_ads_data'
end

every 1.day, :at => '00:10 am' do
  command 'cd /home/ritika/RubymineProjects/Puneet/stealth_app && bundle install && bin/rake get_notifications'
end
