# --------------------------------------
# Poll tasks
# --------------------------------------

namespace :feedback do
  
  desc "Reports the stats for all the current polls"
  task :report_polls => :environment do
    note "Getting stats for all polls"
    polls = Feedback::Poll.all
    
    return unless polls
    
    note "Votes by poll:"
    breaker
    success "#{polls.size} polls found."
    
    polls.each do |poll|
      success poll.title
      
      poll.answers.each do |answer|
        quote "* #{answer.title} (#{answer.entries.size} votes)"
      end
      
      breaker
    end
    
    note "Votes by user:"
    breaker
    
    users = User.all
    
    success "#{users.size} users found."
    
    users.each do |user|
      quote "* #{user.email} (#{user.poll_entries.size})"
    end
  end
  
  desc "Reports the feedback from all users"
  task :report_general => :environment do
    note "Getting feedback..."
    feedback = Feedback::FeedbackEntry.all
    
    return unless feedback
    
    breaker
    success "#{feedback.size} feedback entries found."
    breaker
    
    feedback.each do |f|
      success f.user.email
      quote f.content
      breaker
    end
  end
  
  
end
