# --------------------------------------------------
# Controller Spec: PagesController
# --------------------------------------------------

describe PagesController do
  
  it "should have the correct routes setup" do
    route_for(:controller => "pages", :action => "index").should == "/pages"
    route_for(:controller => "pages", :action => "show", :id => "home").should == "/pages/home"
  end
  
  it "should redirect_to the show page on #index" do
    get :index
    
    response.should be_redirect
    response.should redirect_to(:action => "show", :id => "about")
  end
  
  it "should render the correct view on #show with id 'about'" do
    get "show", :id => "about"
    response.should render_template("pages/_about")
  end
  
  it "should fail to render the correct view on #show with id 'doesnt_exist'" do
    get "show", :id => "doesnt_exist"
    
    response.should be_redirect
    response.should redirect_to("/404.html")
  end
  
end
