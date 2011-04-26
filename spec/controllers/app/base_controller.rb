# --------------------------------------------------
# Controller Spec: App::BaseController
# --------------------------------------------------

describe App::BaseController do
  
  before do
    login!
  end
  
  it "should include the Utils library" do
    controller.class.included_modules.should include(Utils)
  end
  
  it "should set a before filter that returns an instance variable of @user" do
    controller.class.before_filters.should include(:get_current_user)
  end
  
  it "should set a before filter that returns a valid account for @user" do
    controller.class.before_filters.should include(:get_account)
  end
  
  it "should authenticate a request to the app namespace" do
    controller.class.before_filters.should include(:authenticate)
  end
  
  it "should set the default page parameter if none is present" do
    controller.class.before_filters.should include(:assign_default_page)
  end
  
  
  it "should get the latest poll and create a new instance of FeedbackEntry" do
    controller.class.before_filters.should include(:get_poll)
    controller.class.before_filters.should include(:get_feedback_entry)
  end
  
end
