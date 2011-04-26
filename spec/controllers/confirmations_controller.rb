# --------------------------------------------------
# Controller Spec: ConfirmationsController
# --------------------------------------------------

describe ConfirmationsController do
  
  it "should have the application home url set as the url_after_create" do
    controller.url_after_create.should == app_user_path
  end
  
end
