module App
  class DirectMessagesController < BaseController
    
    def index
      @direct_messages = @account.client.direct_messages(:page => params[:page])
    end
    
    def create
      @account.client.direct_message_create(params[:recipient_id], params[:text])
      flash[:notice] = "Your direct message was successfully sent!"
      redirect_back_or app_user_account_direct_messages_path(@account)
    rescue Twitter::General
      flash[:notice] = "Sorry, we could not send that message as #{params[:recipient_id]} is not your friend."
      redirect_back_or app_user_account_direct_messages_path(@account)
    end
    
    def destroy
      @account.client.direct_message_destroy(params[:id])
      flash[:notice] = "Direct message was successfully deleted."
      redirect_back_or app_user_account_direct_messages_path(@account)
    end
    
  end
end
