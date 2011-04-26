#!/usr/bin/env ruby
require 'logger'
require 'yaml'

$LOAD_PATH.unshift ::File.expand_path(::File.dirname(__FILE__) + '/lib')
require 'resque/server'

# Set the RESQUECONFIG env variable if you've a `resque.rb` or similar
# config file you want loaded on boot.
if ENV['RESQUECONFIG'] && ::File.exists?(::File.expand_path(ENV['RESQUECONFIG']))
  load ::File.expand_path(ENV['RESQUECONFIG'])
end

# Load the config located within the rails app
rails_root = ENV['RAILS_ROOT'] || File.dirname(File.dirname(__FILE__) + '/../../../../')
rails_env  = ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'staging'

resque_config = YAML.load_file(rails_root + '/config/resque.yml')
Resque.redis  = resque_config[rails_env]

if resque_config["auth"]
  auth = resque_config["auth"]
  
  Resque::Server.use Rack::Auth::Basic do |username, password|
    username == auth["username"] and password == auth["password"]
  end
end

use Rack::ShowExceptions
run Resque::Server.new
