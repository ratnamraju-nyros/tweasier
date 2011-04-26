module App
  class SearchConditionsController < BaseController
    before_filter :get_search, :only => [:create, :destroy]
    
    def create
      @condition = @search.conditions.build(params[:condition])
      
      if @condition.save
        flash[:success] = "Search condition was successfully created."
        redirect_to app_user_account_search_path(@account, @condition.search)
      else
        flash[:failure] = "Please check you have provided a value for this condition and it is within #{SearchCondition::LENGTH_RANGE} characters."
        redirect_to app_user_account_search_path(@account, @condition.search)
      end
    end
    
    def destroy
      @condition = @search.conditions.find params[:id]
      @condition.destroy
      flash[:success] = "Search condition was successfully removed."
      redirect_to app_user_account_search_path(@account, @search)
    end
    
    protected
    def get_search
      @search = @account.searches.find params[:search_id]
    end
  end
end
