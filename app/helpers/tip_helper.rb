module TipHelper
  
  def render_tip key=:general
    tip = case key
    when :general
      ["If you want to find out more about the Tweasier team read our blog it's full of free advice, tools and apps you can you to make Twitter much more useful and effective.",
       "Before you start making use of Tweasier, we suggest you take a good look at the list of people you are currently following. If you think some people may be worth removing do it now and then this frees up some space for when we start helping you find people to follow.",
       "Make sure you complete your one-line bio and include your website or blog link in it. If I don't know who they are I won't follow them simple as that.",
       "Try to use a picture of yourself rather than a logo. Also why not add a bespoke background there are loads of free services out there like #{link_to "Twitter Backgrounds", "http://www.twitterbackgrounds.com/"}.",
       "As a rule try to keep your ratio of followers to followees around 1:1 as Twitter likes this and so do other users",
       "Use a Twitter client to group your followers, so you can follow different groups on different topics - the best Twitter client out there in our opinion is #{link_to "Tweetdeck", "http://www.tweetdeck.com/"}."]
    when :tweets
      ["Always treat Twitter like your own personal community not your local advertisement. In other words share stuff don't push too much.",
      "Make sure you set up a Twitter search to monitor for your company name, competitors and other relevant businesses. If you monitor first you can see how people interact in your sector. #{link_to "Tweetdeck", "http://www.tweetdeck.com/"} has a great search section.",
      "When tweeting think quality over quantity. Who cares about what you are having for lunch apart from you?",
      "Try to offer advice or share your own tips (like these) on your area of expertise"]
    when :email_notifications
      "If you want to avoid getting Twitter emails every five minutes, disable your Twitter email notices by clicking #{link_to "here", "http://twitter.com/account/notifications"}, and unticking the boxes, and then simply choose our daily notification which will send you one email per day instead of 50 and it contains loads more statistics."
    when :retweets
      ["Actually click the retweet button when someone you are following says something interesting. Twitter is about conversation not just broadcasting your own stuff. You may also find that person says thanks - you have started to build a relationship. Why not say thanks when others retweet your messages?",
       "As a rule try not to tweet more than 10 times in a day as too much tweeting can become a bit irritating to your followers and on the flip side this will save you time."]
     when :mentions
       "Be polite and thank people when they help you out with useful information and point your followers to other people who have good information too."
    end
    
    tip = tip[rand(tip.size)] if tip.is_a?(Array) # Need to - 1 from the tip.size?
    
    return unless tip
    
    content_for :tip do
      render :partial => "app/shared/tip", :locals => { :tip => tip }
    end
  end
  
end
