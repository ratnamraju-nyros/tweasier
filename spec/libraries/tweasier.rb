# --------------------------------------------------
# Lib Spec: Tweasier
# --------------------------------------------------

describe Tweasier do
  
  it "should have a global logging function" do
    Tweasier.logger("Testing").should be_true
  end
  
end
