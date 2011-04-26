module App
  class SearchResultsController < BaseController
    before_filter :get_search, :only => [:create]
    
    def create
      respond_to do |wants|
        wants.js do
          if @search.parameterize.blank?
            @results        = []
            @results_people = []
          else
            @results = Tweasier::Search::Base.new(@search.parameterize).run!
            
            # Filter results for unique people from statuses
            people          = {}
            @results_people = []
          
            @results.each do |r|
              people.merge!(r.from_user => { :id => r.id,
                                             :screen_name => r.from_user,
                                             :profile_image_url => r.profile_image_url
                                            })
            end
          
            people.each do |person|
              @results_people << Hashie::Mash.new({:screen_name => person[1][:screen_name],
                                           :profile_image_url => person[1][:profile_image_url],
                                           :id => person[1][:id]
                                          })
            end
          end
        end
      end
    end
    
    def follow
      respond_to do |wants|
        wants.js do
          queued_screen_names = params[:search_results][:screen_names].split(",")
          search_id           = params[:search_results][:search_id]
          
          if queued_screen_names.present?
            queued_screen_names.each { |name| Resque.enqueue(Tweasier::Jobs::Follow, @account.id, name, search_id) }
            render :json => { :text => "We are now completing your request." }
          else
            render :json => { :text => "Could not find users to follow." }
          end
        end
      end
    end
    
    protected
    def get_search
      @search = @account.searches.find params[:search_id]
    end
  end
end
