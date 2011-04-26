module App
  class SearchBatchesController < BaseController
    before_filter :calculate_fields_to_generate
    
    def new
      @search = @account.searches.build
    end
    
    def create
      titles = params[:titles].reject { |s| s.blank? }
      errors = []
      
      if titles.empty?
        flash[:failure] = "Please provide titles for at least one search."
        render :new
        return
      end
      
      titles.each do |title|
        search = @account.searches.build(:title => title)
        errors << "'#{title}'" unless search.save
      end
      
      if errors.empty?
        flash[:success] = "Searches were successfully created."
      else
        flash[:failure] = "Searches were successfully created except #{errors.join(",")} as the titles where already taken."
      end
      redirect_to app_user_account_searches_path(@account)
    end
    
    private
    def calculate_fields_to_generate
      @fields_to_generate = ((params[:count] and (1..20).to_a.include?(params[:count].to_i)) ? params[:count] : 5).to_i
    end
  end
end
