# --------------------------------------------------
# Helper Spec: AjaxHelper
# --------------------------------------------------

describe AjaxHelper do
  include AjaxHelper
  
  describe "loading_link_to" do
    
    it "should return a link with an .ajax class from the #loading_link_to method" do
      loading_link_to("hello", "world").should == link_to("hello", "world", :class => "ajax")
    end
    
    it "should return a link with an .ajax and .other class from the #loading_link_to method" do
      loading_link_to("hello", "world", :class => "other").should == link_to("hello", "world", :class => "ajax other")
    end
    
  end
end
