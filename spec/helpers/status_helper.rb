# --------------------------------------------------
# Helper Spec: ListHelper
# --------------------------------------------------

describe StatusHelper do
  include StatusHelper
  
  before do
    @account = App::Account.make
    @status = Mash.new :text => "hello @josh hows it going?"
  end
  
  describe "format_status" do
    it "should return an autolinked block of text from a status" do
      format_status(@status).should == ('hello <a href="/app/user/accounts/' + @account.username + '/people/josh">@josh</a> hows it going?')
    end
  end
  
  describe "pretty_datetime" do
    it "should return a human readable, formatted datetime string" do
      datetime = "Thu, 03 Dec 2009 15:53:11 +0000"
      
      pretty_datetime(datetime).should == "Dec  3, 2009  3:53pm"
    end
  end
  
  describe "link_to_twitter_status" do
    it "should return a correctly formated twitter URL for a single status" do
      link_to_twitter_status("permalink", "12345", "joshnesbitt").should == '<a href="http://twitter.com/joshnesbitt/status/12345">permalink</a>'
    end
  end
end
