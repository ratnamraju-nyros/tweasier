module App
  module Statistics
    class AccountsController < BaseController
      
      def show
        @person = @account.client.user(@account.username)
        
        respond_to do |wants|
          wants.html
          wants.chart do
            values = []
            
            values << { :value => @person.friends_count, :label => "following" }
            values << { :value => @person.followers_count, :label => "followers" }
            
            chart = build_pie_chart(values, "#val# people<br>#percent#")
            
            render :text => chart.render
          end
          
        end
      end
      
    end
  end
end
