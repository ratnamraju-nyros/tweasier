module App
  class MentionsController < BaseController
    
    def index
      @mentions = @account.client.mentions(:page => params[:page])
    end
    
  end
end
