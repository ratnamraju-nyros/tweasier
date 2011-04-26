module App
  class PeopleController < BaseController
    
    def show
      begin
        @statuses = @account.client.user_timeline(:id => params[:id], :page => params[:page])
        @person   = @account.client.user(params[:id])
      rescue Twitter::NotFound
        render_error 404
      end
    end
    
  end
end
