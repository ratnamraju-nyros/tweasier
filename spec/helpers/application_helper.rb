# --------------------------------------------------
# Helper Spec: ApplicationHelper
# --------------------------------------------------

describe ApplicationHelper do
  include ApplicationHelper
  
  before do
    App::Account.destroy_all
    define_rails_helper_methods!
  end
  
  describe "blog_path" do
    it "should return the relative blog path" do
      blog_path.should == "/blog"
    end
  end
  
  describe "sidebar" do
    it "should capture the content for the sidebar" do
      sidebar do
        "sidebar content"
      end

      # As we are executing the above method within this
      # context we can simply get the instance variable that
      # the content_for method sets and assert the value
      # from within this test block.
      @content_for_sidebar.should == "sidebar content"
    end
  end
  
  describe "shared" do
    it "should render a partial located within the /shared view directory" do
      shared("navigation").should == "rendered content"
    end
  end
  
  describe "yield_javascript_vars" do
    it "should render nothing as no current user is present" do
      self.stub!(:current_user).and_return(nil)
      yield_javascript_vars.should == nil
    end
    
    it "should render a multiline block of javascript variables within script tags populated with user information" do
      user = User.make
      self.stub!(:current_user).and_return(user)
      
      yield_javascript_vars.should == "<script type=\"text/javascript\">\n//<![CDATA[\nwindow._current_user       = #{user.id};\nwindow._authenticity_token = '';\n\n//]]>\n</script>"
    end
    
    it "should render a multiline block of javascript variables within script tags populated with user AND account information" do
      user = User.make
      @account = App::Account.make
      self.stub!(:current_user).and_return(user)
      
      yield_javascript_vars.should == "<script type=\"text/javascript\">\n//<![CDATA[\nwindow._current_user       = #{user.id};\nwindow._authenticity_token = '';\nwindow.statuses_path           = '/app/user/accounts/#{@account.username}/statuses';\nwindow.direct_messages_path    = '/app/user/accounts/#{@account.username}/direct_messages';\nwindow.new_search_batches_path = '/app/user/accounts/#{@account.username}/search_batches/new';\n//]]>\n</script>"
    end
  end

end
