require 'machinist/active_record'
require 'sham'

["spec/blueprints/*/*/*.rb", "spec/blueprints/*/*.rb", "spec/blueprints/*.rb"].each { |g| Dir.glob(g).each { |f| require f } }
