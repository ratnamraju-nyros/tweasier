require 'machinist/active_record'
require 'sham'
require 'faker'

module App
  
  Account.blueprint do
    user { User.make }
    username { Sham.username.gsub(".", "") }
    atoken   { Sham.hash }
    asecret  { Sham.hash }
  end
  
end
