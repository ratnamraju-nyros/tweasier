# -----------------------------------------------
# Tweasier jobs
# -----------------------------------------------

namespace :jobs do

  desc "Generates followers for all accounts that have the auto_follow tool enabled."
  task :auto_follow => :environment do
    note "Beggining auto follow"
    breaker
    
    accounts = App::Account.auto_followable
    raise "No accounts found with the auto_follow preference on!" unless accounts.present?
    
    accounts.reject! { |a| a.searches.blank? }
    
    accounts.each do |account|
      quote "#{account.username} (#{account.searches.size} rules)"
      account.queue_auto_follow!
    end
    
    breaker
    success "#{accounts.size} accounts have had auto follow jobs dispatched."
  end
  
  desc "Prunes followers for all accounts that have the auto_unfollow tools enabled."
  task :auto_unfollow => :environment do
    note "Beginning auto unfollow"
    breaker
    
    accounts = App::Account.auto_unfollowable
    counter  = 0
    raise "No accounts found with the auto_unfollow preference on!" unless accounts.present?
    
    accounts.each do |account|
      unless account.followed_people.for_unfollower.empty?
        quote "#{account.username} (following #{account.followed_people.count} people through Tweasier)"
        account.queue_auto_unfollow!
        counter += 1
      end
    end
    
    breaker
    success "#{counter} accounts have had auto unfollow jobs dispatched."
  end
  
  namespace :mailer do
    desc "Sends out the daily email digest to all accounts who wish to receive them."
    task :send_daily_digest => :environment do
      note "Beginning daily digest"
      breaker
      
      accounts = App::Account.daily_digest
      
      raise "No accounts found with the daily digest preference on!" unless accounts.present?
      
      accounts.each do |account|
        quote "+ #{account.username}"
        account.queue_daily_digest_mail!
      end
      
      breaker
      success "#{accounts.size} accounts have had daily digest jobs dispatched."
    end
    
    desc "Sends out the weekly email digest to all accounts who wish to receive them."
    task :send_weekly_digest => :environment do
      note "Beginning weekly digest"
      breaker
      
      accounts = App::Account.weekly_digest
      
      raise "No accounts found with the weekly digest preference on!" unless accounts.present?
      
      accounts.each do |account|
        quote "+ #{account.username}"
        account.queue_weekly_digest_mail!
      end
      
      breaker
      success "#{accounts.size} accounts have had weekly digest jobs dispatched."
    end
  end
end
