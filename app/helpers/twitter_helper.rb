module TwitterHelper
  
  def link_to_twitter_person(text, person, opts={})
    link_to text, "http://twitter.com/#{person}", opts
  end
  
end