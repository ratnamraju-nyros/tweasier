# --------------------------------------------------
# Lib Spec: Filter
# --------------------------------------------------

describe Tweasier::Follower::Filter do
  
  before do
    @account = App::Account.make
    @results = [Hashie::Mash.new(:from_user => "TestUser1"),
                Hashie::Mash.new(:from_user => "TestUser2"),
                Hashie::Mash.new(:from_user => "TestUser3"),
                Hashie::Mash.new(:from_user => "TestUser3"),
                Hashie::Mash.new(:from_user => "TestUser4"),
                Hashie::Mash.new(:from_user => "TestUser4")]
  end
  
  it "should filter out unique ids from a collection of search results" do
    # stub_get('/followers/ids.json', 'follower_ids')
    
    filtered = Tweasier::Follower::Filter.new(@account, @results).run!
    filtered.should have(4).filtered_results
  end
  
end
