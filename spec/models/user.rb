# --------------------------------------------------
# Model Spec: User
# --------------------------------------------------

describe User do
  
  before(:all) do
    User.destroy_all
  end
  
  before(:each) do
    @user = User.make
  end
  
  it "should be valid" do
    @user.should be_valid
  end
  
  it "should include the Clearance authentication plugin" do
    User.included_modules.should include(Clearance::User)
  end
  
  it "should have many accounts" do
    @user.should have_many(:accounts)
  end
  
  it "should have many poll entries" do
    @user.should have_many(:poll_entries)
  end
  
  it "should have many feedback entries" do
    @user.should have_many(:feedback_entries)
  end
  
  it "should fail on validating the length of #password (too short)" do
    @user.password              = "short"
    @user.password_confirmation = "short"
    
    @user.save.should be_false
  end
  
  it "should fail on validating the length of #password (too long)" do
    @user.password              = "averyveryveryveryveryveryveryverylongpassword"
    @user.password_confirmation = "averyveryveryveryveryveryveryverylongpassword"
    
    @user.save.should be_false
  end
  
  it "should pass on validating the length of #password" do
    @user.password              = "apassword"
    @user.password_confirmation = "apassword"
    
    @user.save.should be_true
  end
  
  it "should return the correct user #handle" do
    @user.handle.should == @user.email.split("@").first
  end
  
  it "should return an empty array of answered poll ids" do
    @user.should have(0).answered_poll_ids
  end
  
  it "should return a populated array of answered poll ids" do
    @user.poll_entries << Feedback::PollEntry.make
    @user.poll_entries << Feedback::PollEntry.make
    @user.poll_entries << Feedback::PollEntry.make
    
    @user.should have(3).answered_poll_ids
  end
end
