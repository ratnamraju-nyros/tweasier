# --------------------------------------------------
# Helper Spec: TwitterHelper
# --------------------------------------------------

describe TwitterHelper do
  include TwitterHelper
  
  describe "link_to_twitter_person" do
    it "should return a link to a twitter user" do
      link_to_twitter_person("permalink", "joshnesbitt").should == '<a href="http://twitter.com/joshnesbitt">permalink</a>'
    end
  end
end
