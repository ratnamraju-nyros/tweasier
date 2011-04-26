module App
  module Statistics
    class SearchesController < BaseController
      
      def index
        @followed      = @account.followed_people.count
        @unfollowed    = @account.unfollowed_people.count
        total_people   = @followed + @unfollowed
        
        @followed_percentage   = @followed.as_percentage_of(total_people)
        @unfollowed_percentage = @unfollowed.as_percentage_of(total_people)
        
        @ignored       =  @account.ignored_people.count
        @suspended     = @account.suspended_people.count
        @searches      = @account.searches.all :include => [:followed_people, :unfollowed_people]
        
        @unaccountable_followed   = @account.followed_people.all(:conditions => ['search_id IS NULL'])
        @unaccountable_unfollowed = @account.unfollowed_people.all(:conditions => ['search_id IS NULL'])
        @unaccountable = @unaccountable_followed + @unaccountable_unfollowed
        
        @total_search_people = @searches.collect { |s| s.followed_people.count }.inject(nil) { |sum, x| sum ? sum + x : x } + @unaccountable.size
        
        respond_to do |wants|
          wants.html do
            # Get the total
            @total_found = @followed + @unfollowed + @ignored + @suspended + @unaccountable.size
          end
          wants.chart do
            values = []
            
            case params[:chart_id]
            when "follower"
              # Chart for followered/unfollowed
              values << { :value => @followed, :label => "Followed (#{@followed})" }
              values << { :value => @unfollowed, :label => "Unfollowed (#{@unfollowed})" }
              
              chart = build_pie_chart(values, "#val# people<br>#percent#")
            when "search_followed"
              # Chart for search effectiveness by followed
              @searches.each do |search|
                values << {:value => search.followed_people.count, :label => "#{search.title} (#{search.followed_people.count} people)" }
              end
              
              values << { :value => @unaccountable.size, :label => "Unaccountable (#{@unaccountable.size} people)" }
              chart = build_bar_chart(values, "#val# people", "followed users")
            when "search_unfollowed"
              # Chart for search effectiveness by unfollowed
              @searches.each do |search|
                values << {:value => search.unfollowed_people.count, :label => "#{search.title} (#{search.unfollowed_people.count} people)" }
              end
              
              values << { :value => @unaccountable.size, :label => "Unaccountable (#{@unaccountable.size} people)" }
              chart = build_bar_chart(values, "#val# people", "unfollowed users")
            end
            
            render :text => chart.render
          end
        end
      end
      
    end
  end
end
