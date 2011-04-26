module StatusHelper
  
  def format_status(status)
    text           = status.text
    text.gsub!(/@([\w]+)(\W)?/, '<a href="/app/user/accounts/**_id_**/people/\1">@\1</a>\2')
    text.gsub!("**_id_**", @account.username)
    # For now lets just link to Twitter with hashtags
    text.gsub!(/#([\w]+)(\W)?/, '<a href="http://search.twitter.com/search?q=%23\1">#\1</a>\2')
    auto_link(text)
  end
  
  def pretty_datetime(datetime)
    datetime = Time.parse(datetime)
    date = datetime.strftime('%b %e, %Y')
    time = datetime.strftime('%l:%M%p').downcase
    "#{date} #{time}"
  end
  
  def link_to_twitter_status(text, id, user, opts={})
    link_to text, "http://twitter.com/#{user}/status/#{id}", opts
  end
  
end
