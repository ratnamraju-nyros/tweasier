# --------------------------------------------------
# Lib Spec: Remote
# --------------------------------------------------

module Tweasier::Client
  describe Remote do

    before do
      @account = App::Account.make
      @remote  = Remote.new(@account, "eef8aef6018d69eb772ce1e5edffce9c7f6bc39d82280", "af3a5c541e41670767f63abc524e37e3d48768c153febdcd")
    end
    
    # Stub
    
  end
end
