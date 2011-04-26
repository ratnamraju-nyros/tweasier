# --------------------------------------------------
# Lib Spec: Utils
# --------------------------------------------------

describe Utils do
  include Utils
  
  describe "array_from_links_in_string" do
    it "should create an array from a string of URLs" do
      array_from_links_in_string("hello www.google.com and http://josh-nesbitt.net from within a string").should have(2).urls
      
      urls = array_from_links_in_string("hello www.google.com and http://josh-nesbitt.net from within a string")
      urls.first.should == "www.google.com"
      urls.last.should  == "http://josh-nesbitt.net"
    end
    
    it "should return a blank array from a string with containing no URLs" do
      array_from_links_in_string("hello from within a string").should have(0).urls
    end
  end

end
