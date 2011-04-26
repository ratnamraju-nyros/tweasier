module Feedback
  class FeedbackEntriesController < ApplicationController
    
    def create
      respond_to do |wants|
        wants.js do
          f = FeedbackEntry.new(:content => params[:feedback_entry][:content], :user => current_user)
          if f.save
            render :json => { :text => "Thanks for helping make Tweasier better!" }
          else
            render :json => { :text => "Sorry there was a problem leaving your feedback." }
          end
        end
      end
    end
    
  end
end
