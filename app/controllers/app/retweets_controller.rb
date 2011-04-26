module App
  class RetweetsController < BaseController
    
    def index
      @retweets = case (params[:filter] || "all").to_sym
      when :by_me then @account.client.retweeted_by_me(:page => params[:page])
      when :to_me then @account.client.retweeted_to_me(:page => params[:page])
      when :of_me then @account.client.retweets_of_me(:page => params[:page])
      else
        @account.client.retweeted_by_me(:page => params[:page])
      end
    end
    
    def create
      respond_to do |wants|
        wants.js do
          begin
            @account.client.retweet(params[:status_id])
            render :json => { :text => "Status retweeted!" }
          rescue Twitter::General
            render :json => { :text => "Already retweeted!" }
          end
        end
      end
    end
    
  end
end
