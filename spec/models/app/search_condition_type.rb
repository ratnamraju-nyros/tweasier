# --------------------------------------------------
# Model Spec: SearchConditionType
# --------------------------------------------------

module App
  describe SearchConditionType do

    before(:all) do
      [User, Account, Search, SearchCondition, SearchConditionType].each { |c| c.destroy_all }
    end

    before(:each) do
      @search_condition_type = SearchConditionType.make
    end
    
    it "should be valid" do
      @search_condition_type.should be_valid
    end
    
    it "should have many conditions" do
      @search_condition_type.should have_many(:conditions)
    end
    
    it "should require a value to be assigned to it and have value_required? delegated to it" do
      3.times { @search_condition_type.conditions.make }
      
      @search_condition_type.operator       = ":"
      @search_condition_type.value_required = true
      @search_condition_type.save
      
      @search_condition_type.value_required?.should be_true
      @search_condition_type.conditions.first.value_required?.should be_true
      
      @search_condition_type.operator       = "="
      @search_condition_type.value_required = false
      @search_condition_type.save
      
      @search_condition_type.value_required?.should be_false
      @search_condition_type.conditions.first.value_required?.should be_false
    end
    
    it "should require processing when a processor is defined" do
      @search_condition_type.requires_processing?.should be_false
      
      @search_condition_type.processor = :geocode
      @search_condition_type.save!
      
      @search_condition_type.requires_processing?.should be_true
    end
  end
end
