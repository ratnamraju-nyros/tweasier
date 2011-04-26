# --------------------------------------------------
# Lib Spec: Base
# --------------------------------------------------

module Tweasier::Client
  describe Base do

    before do
      @account = App::Account.make
      @base    = Base.new(@account, "eef8aef6018d69eb772ce1e5edffce9c7f6bc39d82280", "af3a5c541e41670767f63abc524e37e3d48768c153febdcd")
    end

    it "should have a valid instance of a local client" do
      @base.local_client.should be_instance_of(Tweasier::Client::Local)
    end

    it "should have a valid instance of a remote client" do
      @base.remote_client.should be_instance_of(Tweasier::Client::Remote)
    end
    
  end
end
