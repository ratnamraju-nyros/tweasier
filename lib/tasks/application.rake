namespace :application do
  
  desc "Bootstraps the application and dependencies"
  task :bootstrap => :environment do
    puts ">> Please check:"
    puts "- Redis is already started"
    system "COUNT=5 QUEUE=* rake resque:workers"
  end
  
end
