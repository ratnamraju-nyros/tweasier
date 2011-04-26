# --------------------------------------
# Resque specific tasks
# --------------------------------------
require File.join(File.dirname(__FILE__), "..", "tweasier")

desc "Prepares resque with the Rails environments and other configurations."
task "resque:setup" => :environment do
  
  # Add anything resque needs to know in here (like passing it the environment).
  
end

namespace :resque do
  
  desc "Dispatches a test job onto the Resque queue."
  task :test_job => :environment do
    puts ">> Testing Resque Job..."
    Resque.enqueue(Tweasier::Jobs::Test, 1)
    puts ">> Done Testing Resque Job"
  end
  
end
