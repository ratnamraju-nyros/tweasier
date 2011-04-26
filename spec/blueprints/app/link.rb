require 'machinist/active_record'
require 'sham'
require 'faker'

module App
  
  Link.blueprint do
    account { Account.make }
    unique_hash { Sham.hash }
    user_hash { Sham.hash }
    long_url { "http://www.example.com/#{rand(999999)}" }
    short_url { "http://bit.ly/#{rand(999999)}" }
    cached_clickcount { rand(999999) }
    cached_user_clickcount { rand(999999) }
  end
  
end
