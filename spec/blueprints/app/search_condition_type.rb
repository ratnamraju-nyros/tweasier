require 'machinist/active_record'
require 'sham'
require 'faker'

module App
  
  SearchConditionType.blueprint do
    label { "does not contain" }
    operator { "-" }
    value_required { true }
  end
  
end
