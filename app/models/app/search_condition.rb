module App
  class SearchCondition < ActiveRecord::Base
    belongs_to :search, :class_name => "App::Search",              :foreign_key => :search_id
    belongs_to :type,   :class_name => "App::SearchConditionType", :foreign_key => :search_condition_type_id
    
    LENGTH_RANGE       = 2..50.freeze
     GEOLOCATION_RADIUS = "100".freeze
    
    
    delegate :value_required?, :operator, :requires_processing?, :processor, :to => :type
    
    validates_presence_of :search, :type
    validates_presence_of :value, :if => :value_required?
    validates_length_of :value, :within => LENGTH_RANGE, :if => :value_required?
    
    def parameterize
    
      self.requires_processing? ? self.process! : self.parameterized_value
    end
    
    def process!
      return unless self.requires_processing?
      case self.processor.to_syms
        when :geocode
        # Pre process the value by finding the correct geocode for the search
        # term before submitting to the Twitter search. For now we hardcode the radius.
        address = Tweasier::Geolocation::Base.locate(self.value)
        
        geo_radius = SearchCondition.find(:first, :conditions => ["search_condition_type_id like ? and search_id like ?", self.search_condition_type_id, self.search_id])
        geocode_radius = !geo_radius.blank? ?  geo_radius.value : GEOLOCATION_RADIUS
       
        address.nil? ? "" : self.parameterized_value("#{address.coordinates[1]},#{address.coordinates[0]},#{geocode_radius}mi")
        when :within
         # should not do anything 
        else
        self.parameterized_value
      end
    end
    
    def parameterized_value override_value=nil
      self.value_required? ? "#{self.operator}#{override_value ? override_value : self.value}" : self.operator
    end
  end
end
