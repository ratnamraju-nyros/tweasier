# -----------------------------------------------------
# Controller Spec: Feedback::FeedbackEntriesController
# -----------------------------------------------------

describe Feedback::FeedbackEntriesController do
  
  before(:all) do
    User.destroy_all
  end
  
  before(:each) do
    login!
  end
  
  it "should have the correct routes setup" do
    route_for(:controller => "feedback/feedback_entries", :action => "index").should == "/feedback/feedback_entries"
  end
  
  it "should create a new feedback entry on #create" do
    xhr :post, :create, :feedback_entry => { :content => "Awesome app." }
    
    response.body.should =~ /Thanks/
  end
  
  it "should fail to create a new feedback entry on #create" do
    xhr :post, :create, :feedback_entry => { :content => nil }
    
    response.body.should =~ /Sorry/
  end
  
end
