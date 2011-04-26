require 'machinist/active_record'
require 'sham'
require 'faker'

module Feedback
  
  Poll.blueprint do
    title { Sham.title }
  end
  
end
