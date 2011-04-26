module App
  class StatusesController < BaseController
    
    def show
      begin
        @status = @account.client.status(params[:id])
      rescue Twitter::NotFound
        render_error 404
      end
    end
    
    def create
      options = {}
      
      if @account.geotagging_available?
        options.merge! :lat  => @account.location[:lat]
        options.merge! :long => @account.location[:long]
      end
      
      unless params[:in_reply_to_status_id].blank?
        options.merge!({:in_reply_to_status_id => params[:in_reply_to_status_id]})
      end
      
      respond_to do |wants|
        wants.js do
          begin
            @account.client.update(params[:text])
            render :json => { :text => "Status successfully tweeted!" }
          rescue Twitter::General
            render :json => { :text => "Could not tweet status." }
          end
        end
        wants.html do
          begin
            @account.client.update(params[:text], options)
            flash[:notice] = "Successfully tweeted."
            redirect_back_or app_user_account_path(@account)
          rescue Twitter::General
            flash[:failure] = "An error occured whilst tweeting. Please ensure you provided a tweet."
            redirect_back_or app_user_account_path(@account)
          end
        end
      end
    end
    
    def destroy
      @account.client.status_destroy(params[:id])
      flash[:notice] = "Tweet successfully removed, it may take a few minutes to remove from our cache."
      redirect_back_or app_user_account_path(@account)
    end
    
  end
end
