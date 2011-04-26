RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  
  config.gem 'rack'
  config.gem 'haml',                    :lib => 'haml'
  config.gem 'pat-maddox-giternal',     :lib => 'giternal'
  config.gem 'thoughtbot-clearance',    :lib => 'clearance'
  config.gem 'resque',                  :lib => 'resque', :source => 'http://gemcutter.org'
  config.gem 'whenever',                :lib => false,    :source => 'http://gemcutter.org'
  config.gem 'friendly_id'
  config.gem 'twitter'
  config.gem 'hashie'
  config.gem 'bitly'
  config.gem 'configr'
  config.gem 'rest-client'
  
  config.frameworks -= [:active_resource]
  config.active_record.observers = "app/account_observer"
  config.time_zone = 'London'
  
end
