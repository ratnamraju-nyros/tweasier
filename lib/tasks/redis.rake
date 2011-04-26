# This is a tweaked version of the redis utils shipped with Redis.
# It enables us to start different redis installations depending on
# the environment.
require 'fileutils'
require 'open-uri'

resque_config_file = File.join(RAILS_ROOT, "config", "resque.yml")
resque_config      = YAML.load_file(resque_config_file)
puts "RESQUE CONF #{resque_config.inspect}"
raise "No config file found in #{config_file}" unless resque_config and resque_config_file

REDIS_CONFIG = resque_config[RAILS_ENV].split(":")
CONFIG_FILE  = "/etc/redis-#{RAILS_ENV}.conf"
DTACH_SOCKET = "/tmp/redis-#{RAILS_ENV}.dtach"

class RedisRunner
  
  def self.redisconfdir
    CONFIG_FILE
  end
  
  def self.dtach_socket
    DTACH_SOCKET
  end
  
  def self.running?
    File.exists? dtach_socket
  end
  
  def self.start
    puts "Detach with Ctrl+\ Re-attach with rake redis:attach"
    sleep 2
    exec "dtach -A #{dtach_socket} redis-server #{redisconfdir}"
  end
  
  def self.attach
    exec "dtach -a #{dtach_socket}"
  end
  
  def self.stop
    sh "echo 'SHUTDOWN' | nc #{REDIS_CONFIG[0]} #{REDIS_CONFIG[1]}"
  end
  
end

namespace :redis do
  
  desc 'Start redis'
  task :start do
    RedisRunner.start
  end

  desc 'Stop redis'
  task :stop do
    RedisRunner.stop
  end

  desc 'Restart redis'
  task :restart do
    RedisRunner.stop
    RedisRunner.start
  end

  desc 'Attach to redis dtach socket'
  task :attach do
    RedisRunner.attach
  end
  
end
