module App
  class SpamReportsController < BaseController
    
    def create
      respond_to do |wants|
        wants.js do
          begin
            @account.client.report_spam(params[:user])
            render :json => { :text => "Spam reported, thanks!" }
          rescue Twitter::General
            render :json => { :text => "Could not report spam, sorry." }
          end
        end
      end
    end
    
  end
end
