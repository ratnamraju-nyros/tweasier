$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'yaml'
require 'resque'
# Load the config located within the rails app
rails_root = ENV['RAILS_ROOT'] || File.dirname(File.dirname(__FILE__) + '/../../../../../')
rails_env  = ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'

resque_config = YAML.load_file(rails_root + '/config/resque.yml')
Resque.redis  = resque_config[rails_env]

require 'resque/tasks'