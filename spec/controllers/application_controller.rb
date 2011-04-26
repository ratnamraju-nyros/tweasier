# --------------------------------------------------
# Controller Spec: ApplicationController
# --------------------------------------------------

describe ApplicationController do
  
  it "should include the Clearance library" do
    controller.class.included_modules.should include(Clearance::Authentication)
  end
  
  it "should include the Tweasier::StagingAuthentication library" do
    controller.class.included_modules.should include(Tweasier::Authentication)
  end
  
end
