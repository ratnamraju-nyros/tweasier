require 'ostruct'
require 'rest-client'
class HomeController< ApplicationController
  
  def show
    # Get latest blog posts from RSS
    if Tweasier::Cache::Base.exists?("blog_posts")
      @blog_feed = Tweasier::Cache::Base.get("blog_posts")
    else
      remote_feed = RestClient.get(Configuration.blog.feed_url)
      local_feed  = Hash.from_xml(remote_feed)
      local_feed  = local_feed["rss"]["channel"]["item"].slice!(0..3)
      feed_items  = []
      
      local_feed.each do |item|
        feed_items << OpenStruct.new(:title => item["title"], :description => item["description"], :link => item["guid"])
      end
      
      Tweasier::Cache::Base.set("blog_posts", feed_items, :expires_in => Configuration.blog.cache_period.to_i.hours)
      @blog_feed = feed_items
    end
  end
  
end
