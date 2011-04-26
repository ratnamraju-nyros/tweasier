# --------------------------------------------------
# Model Spec: SearchCondition
# --------------------------------------------------

module App
  describe SearchCondition do

    before(:all) do
      [User, Account, Search, SearchCondition, SearchConditionType].each { |c| c.destroy_all }
    end

    before(:each) do
      @search_condition = SearchCondition.make
    end
    
    it "should belong to a search" do
      @search_condition.should belong_to(:search)
    end
    
    it "should belong to a type" do
      @search_condition.should belong_to(:type)
    end
    
    it "should validate presence of search" do
      @search_condition.should validate_presence_of(:search)
    end
    
    it "should validate presence of type" do
      @search_condition.should respond_to(:type)
      @search_condition.type.should_not be_nil
    end
    
    it "should respond to parameterize, returning a correctly formatted parameter" do
      @search_condition.parameterize.should == "-#{@search_condition.value}"
    end
    
    it "should return a correctly paremeterized value given an override value" do
      @search_condition.parameterized_value("myval").should == "-myval"
    end
    
    it "should validate presence and length of value if required" do
      @search_condition.should validate_presence_of(:value)
      @search_condition.should validate_length_of(:value, :within => 2..50)
    end
    
    it "should have a class constant of LENGTH_RANGE" do
      SearchCondition::LENGTH_RANGE.should == (2..50)
    end
    
    it "should delegate value_required?, :operator, :requires_processing?, :processor to SearchConditionType" do
      @search_condition.should respond_to(:value_required?)
      @search_condition.should respond_to(:operator)
      @search_condition.should respond_to(:requires_processing?)
      @search_condition.should respond_to(:processor)
    end
    
  end
end
