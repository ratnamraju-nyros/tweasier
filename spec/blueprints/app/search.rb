require 'machinist/active_record'
require 'sham'
require 'faker'

module App
  
  Search.blueprint do
    title   { Sham.name }
    account { Account.make }
  end
  
end
