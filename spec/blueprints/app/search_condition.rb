require 'machinist/active_record'
require 'sham'
require 'faker'

module App
  
  SearchCondition.blueprint do
    type { SearchConditionType.make }
    search { Search.make }
    value { Sham.name }
  end
  
end
