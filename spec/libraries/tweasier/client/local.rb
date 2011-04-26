# --------------------------------------------------
# Lib Spec: Local
# --------------------------------------------------

module Tweasier::Client
  describe Local do

    before do
      @account = App::Account.make
      @base    = Base.new(@account, "eef8aef6018d69eb772ce1e5edffce9c7f6bc39d82280", "af3a5c541e41670767f63abc524e37e3d48768c153febdcd")
      @local   = Local.new(@base, @account)
    end
    
    after do
      Rails.cache.clear
    end
    
    it "should be delegated to by the client facade" do
      stub_get("/statuses/user_timeline.json", "friends_timeline")
      
      @base.friends_timeline(:page => 1)
    end
    
    it "should successfully cache a key upon initial retrieval" do
      stub_get("/statuses/user_timeline.json", "friends_timeline")
      
      Rails.cache.exist?("#{@local.cache_key_prefix}_friends_timeline_page_1").should be_false
      Rails.cache.read("#{@local.cache_key_prefix}_friends_timeline_page_1").should be_nil
      
      @base.friends_timeline(:page => 1)
      
      Rails.cache.exist?("#{@local.cache_key_prefix}_friends_timeline_page_1").should be_true
      Rails.cache.read("#{@local.cache_key_prefix}_friends_timeline_page_1").should_not be_nil
    end

  end
end
