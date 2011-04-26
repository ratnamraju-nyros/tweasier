# ----------------------------------------------------
# Production specific jobs
# ----------------------------------------------------
set :output,   File.join("log", "production_private_cron.log")

########################
# Mailers
########################
every 1.day, :at => "4pm" do
  rake "jobs:mailer:send_daily_digest RAILS_ENV=production_private"
end

every :friday, :at => '3pm' do
  rake "jobs:mailer:send_weekly_digest RAILS_ENV=production_private"
end

########################
# Follower runner
########################
every 4.hours do
  rake "jobs:auto_follow RAILS_ENV=production_private"
end

########################
# Unfollower runner
########################
every 30.minutes do
  rake "jobs:auto_unfollow RAILS_ENV=production_private"
end
