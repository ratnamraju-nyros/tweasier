module App
  class LinkRequestsController < BaseController
    
    def create
      original_text = params[:text]
      filtered_text = original_text.dup
      
      return unless @account.link_shortening_available?
      
      respond_to do |wants|
        wants.js do
          matches = array_from_links_in_string(filtered_text)
          
          # Add http:// if the prefix is missing
          matches.collect! do |link|
            if link =~ /^http/
              link
            else
              new_link = "http://#{link}"
              filtered_text.gsub!(link, new_link)
              new_link
            end
          end
          
          # Reject bit.ly urls
          matches.reject! { |link| link =~ /^http:\/\/bit.ly/ }
          
          if matches.empty?
            render :json => {:error => "There were no links within your tweet to shorten"}.to_json
            return
          end
          
          # Shorten links
          shortened_links = []
          
          matches.each do |m|
            link = @account.links.build :long_url => m
            link.shorten!
            shortened_links << link
          end
          
          if shortened_links.size == matches.size
            shortened_links.each do |link|
              filtered_text.gsub!(link.long_url, link.short_url)
            end
            
            render :json => {:text => filtered_text}.to_json
          else
            render :json => {:error => "There was a problem completing your request. Please try again"}.to_json
          end
        end
      end
    end
    
  end
end
