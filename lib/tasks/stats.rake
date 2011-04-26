namespace :application do
  
  desc "Cheeky stats overview of people on the site"
  task :stats => :environment do
    puts "Getting stats for all user accounts..."
    users = User.all
    raise "No users!" unless users.present?
    
    success "#{users.size} users found (#{App::Account.count} accounts)."
    
    users.each do |user|
      success "#{user.email} (#{user.accounts.count} accounts)"
      user.accounts.each do |account|
        note account.screen_name
        quote "- follower is #{account.auto_follow ? "ON" : "OFF"}"
        quote "- unfollower is #{account.auto_unfollow ? "ON" : "OFF"}"
        quote "- email notifications are set to '#{account.email_notifications}'"
        quote "- #{account.searches.count} searches"
        quote "- #{account.followed_people.count} followed people"
        quote "- #{account.unfollowed_people.count} unfollowed people"
        
        twitter_account = account.client.user(account.screen_name)
        
        quote "- #{twitter_account.friends_count} total friends"
        quote "- #{twitter_account.followers_count} total followers"
      end
    end
    
    puts "Finished report."
  end
  
end
