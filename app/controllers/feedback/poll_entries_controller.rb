module Feedback
  class PollEntriesController < ApplicationController
    
    def create
      respond_to do |wants|
        wants.js do
          form   = params[:feedback_poll_entry]
          
          unless form[:poll_id] and form[:poll_answer_id]
            render :json => { :text => "Sorry there was a problem leaving your feedback" }
            return
          end
          
          poll   = Poll.find form[:poll_id]
          answer = poll.answers.find form[:poll_answer_id]
          
          if answer.entries.build(:user_id => current_user.id).save
            render :json => { :text => "Thank you for helping make #{Configuration.app.title} better!" }
          else
            render :json => { :text => "Sorry there was a problem leaving your feedback" }
          end
        end
      end
    end
    
  end
end
