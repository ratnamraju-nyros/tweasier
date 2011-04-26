require 'machinist/active_record'
require 'sham'
require 'faker'

User.blueprint do
  email { Sham.email }
  password { "randompassword#{rand(999)}" }
end
