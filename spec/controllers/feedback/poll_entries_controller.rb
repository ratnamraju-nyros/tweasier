# --------------------------------------------------
# Controller Spec: Feedback::PollEntriesController
# --------------------------------------------------

describe Feedback::PollEntriesController do
  
  before(:all) do
    User.destroy_all
    Feedback::Poll.destroy_all
  end
  
  before(:each) do
    login!
  end
  
  it "should have the correct routes setup" do
    route_for(:controller => "feedback/poll_entries", :action => "index").should == "feedback/poll_entries"
  end
  
  it "should create a new poll entry on #create" do
    poll = Feedback::Poll.make do |poll|
      3.times { poll.answers.make }
    end
    
    xhr :post, :create, { :feedback_poll_entry => { :poll_id => poll.id, :poll_answer_id => poll.answers.first.id } }
    
    response.body.should =~ /Thank/
  end
  
  it "should fail to create a new poll entry on #create" do
    poll = Feedback::Poll.make do |poll|
      3.times { poll.answers.make }
    end
    
    xhr :post, :create, { :feedback_poll_entry => { :poll_id => poll.id, :poll_answer_id => nil } }
    
    response.body.should =~ /Sorry/
  end
  
end
