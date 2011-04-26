module App
  class SearchConditionType < ActiveRecord::Base
    has_many :conditions, :class_name => "App::SearchCondition", :foreign_key => :search_condition_type_id, :dependent => :destroy
    
    def requires_processing?
      self.processor.present?
    end
    
  end
end
