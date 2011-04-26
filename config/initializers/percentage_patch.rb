module PercentagePatch
  module InstanceMethods
    
    def as_percentage_of(total)
      return 0 if total == 0
      self.to_f / total * 100
    end
    
  end
end

Integer.instance_eval do
  include PercentagePatch::InstanceMethods
end
