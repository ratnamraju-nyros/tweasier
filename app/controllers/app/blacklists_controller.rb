module App
  class BlacklistsController < BaseController	
    def index    
       @blacklists = @account.blacklists.find(:all)
    end
    
    def new	   
        @blacklist = @account.blacklists.build    
    end
    
    def create      
        @blacklist=@account.blacklists.build(params[:blacklist])
        if @blacklist.save
        flash[:success] = "Blaklist was successfully created."
         redirect_to :action => 'index' 
        else
        flash[:failure] = "Please check you provided the necessary information."
        render :action => "new"
        end
    end
  
    
    def destroy
       @blacklists = @account.blacklists.find(params[:id])
       @blacklists.destroy
       flash[:success] = "Search was successfully removed."
       redirect_to :action => 'index' 
    end   
    
end
end
