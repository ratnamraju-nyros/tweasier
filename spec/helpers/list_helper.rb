# --------------------------------------------------
# Helper Spec: ListHelper
# --------------------------------------------------

describe ListHelper do
  include ListHelper
  
  describe "render_list" do
    
    before do
      define_rails_helper_methods!
    end
    
    it "should render a list partial" do
      render_list(:status, []).should == "rendered content"
    end
  end
end
