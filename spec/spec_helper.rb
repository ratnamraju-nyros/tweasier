ENV["RAILS_ENV"] = "test"
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))
require 'spec/autorun'
require 'spec/rails'
require 'fakeweb'
require "tweasier"
require File.expand_path(File.join(File.dirname(__FILE__), 'blueprints'))
Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))].each { |f| require f }

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = false
  config.use_instantiated_fixtures  = false
  
end

FakeWeb.allow_net_connect = false
