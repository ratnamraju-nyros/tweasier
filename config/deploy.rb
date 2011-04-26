# -------------------------------------
# Main Cap file
# -------------------------------------

# This points cap to the respective deploy script located in recipe_path/rails_env.rb
set :default_env,   'production_private'
set :rails_env,     ENV['rails_env'] || ENV['RAILS_ENV'] || ENV['e'] || default_env
set :recipe_path, 'config/deploy/'

file      = recipe_path + rails_env
file_full = "#{file}.rb"

if recipe_path && File.exists?(file_full)
  puts "Loaded #{file_full}" if load file
else
  puts "Could not find #{file_full}"
end

# additional ssh options & git options
ssh_options[:port]        = 62000
ssh_options[:paranoid]    = false
# set :deploy_via,          :remote_cache
default_run_options[:pty] = true
set :use_sudo, false

set :blog_path, "/home/twdeploy/sites/blog.tweasier.com/current"

namespace :deploy do
    
  desc "Does a backup, updates code, updates externals, symlinks, migrates, notifys hoptoad and restarts."
  task :full do
    #backup
    update_code
    # update_externals
    symlink
    symlink_shared
    migrate
    restart
  end
  
  desc "Creates symlinks for the applications user generated content."
  task :symlink_shared do
    puts "-- creating symlinks..."
    run "rm -rf #{current_path}/public/system"
    run "ln -s #{shared_system} #{current_path}/public/system"
    puts "-- symlinked."
  end
  
  desc "removes random files that are created during updating code"
  task :remove_clutter do
    rails_root = File.expand_path(File.join(File.dirname(__FILE__), ".."))
    files      = [File.join(rails_root, "mkmf.log")]
    
    files.each do |file|
      puts "  ** Removing #{file}"
      system "rm #{file}" if File.exists?(file)
    end
  end
  
  desc "Restarts this application when running passenger"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt" 
    Thread.new { `curl -s http://#{host} $2 > /dev/null` }.kill
  end
  
  desc "Updates GIT externals through giternal"
  task :update_externals do
    run "cd #{release_path} && #{giternal_binary} update"
  end
  
  desc "Backs up the application assets and database content to RAILS_ROOT/../shared/backups"
  task :backup do
    # TODO: write me
  end
  
  desc "Update the crontab file from the rules within config/schedule.rb"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && #{whenever_binary} --update-crontab #{application} --set environment=#{rails_env} --load-file #{release_path}/config/schedule/#{rails_env}.rb"
  end
  
  # Callbacks
  after "deploy:update_code", "deploy:remove_clutter"
  after "deploy:symlink", "deploy:update_crontab"
  
end