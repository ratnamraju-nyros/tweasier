module App
  class SearchesController < BaseController
    before_filter :get_search, :only => [ :show, :edit, :update, :destroy, :perform, :clone ]
    
    def index
      @searches = @account.searches
    end
    
    def new
      @search = @account.searches.build
    end
    
    def create
      @search = @account.searches.build(params[:search])
      
      if @search.save
        flash[:success] = "Search was successfully created."
        redirect_to app_user_account_search_path(@account, @search)
      else
        flash[:failure] = "Please check you provided the necessary information."
        render :action => "new"
      end
    end
    
    def show
      @types = SearchConditionType.all
    end
    
    def edit
    end
    
    def update
      if @search.update_attributes(params[:search])
        flash[:success] = "Search was successfully updated."
        redirect_to app_user_account_search_path(@account, @search)
      else
        flash[:failure] = "Failed to update search, please try again."
        render :action => "edit"
      end
    end
    
    def clone
      previous_search = @account.searches.find(params[:id])
      @search         = @account.searches.build(:title => params[:search][:title])
      
      # Need to also clone the conditions of the search.
      if @search.save and previous_search.conditions.each { |condition| @search.conditions << condition.clone }
        flash[:success] = "Search was successfully cloned."
        redirect_to app_user_account_search_path(@account, @search)
      else
        flash[:failure] = "Sorry that title is already taken, please choose a different title."
        redirect_to app_user_account_search_path(@account, previous_search)
      end
    end
    
    def destroy
      @search.destroy
      flash[:success] = "Search was successfully removed."
      redirect_to app_user_account_searches_path(@account)
    end
    
    protected
    def get_search
      @search = @account.searches.find params[:id]
    end
    
  end
end
