# --------------------------------------------------
# Lib Spec: Base
# --------------------------------------------------

module Tweasier::Cache
  describe Base do
    
    it "should correctly get a value" do
      Base.set("test", "value").should be_true
      Base.exists?("test").should be_true
      Base.get("test").should == "value"
    end
    
    it "should correctly set a value" do
      Base.set("test", "value").should be_true
      Base.exists?("test").should be_true
    end
    
    it "should correctly check if a key exists" do
      Base.set("test", "value").should be_true
      Base.exists?("test").should be_true
      
      Base.exists?("test_random").should be_false
    end
    
    it "should expire a key correctly" do
      Base.set("test", "value").should be_true
      Base.exists?("test").should be_true
      
      Base.expire!("test").should be_true
      Base.exists?("test").should be_false
      
      Base.set("test", "value").should be_true
      Base.exists?("test").should be_true
      
      Base.destroy("test").should be_true
      Base.exists?("test").should be_false
    end
    
    it "should alias #destroy to #expire!" do
      Base.respond_to?(:destroy).should be_true
    end
    
    it "should present a correct Rails cache client" do
      Base.client.class.should == ActiveSupport::Cache::MemCacheStore
    end
  end
end
