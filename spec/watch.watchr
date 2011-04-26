# A simple alternative to autotest that isnt painful
puts ">> Watching spec folder for changes..."

options = {
  :test_all => true,
  :options => "--require 'spec/spec_helper' --format nested --color",
  :binary => "script/spec"
}

watch("(app|spec)/(.*)\.rb") do |match|
  %x[ clear ]
  
  opts   = options[:options]
  binary = options[:binary]
  
  if options[:test_all]
    files = []
    
    %w{ controllers models helpers views libraries }.each do |dir|
      ["spec/#{dir}/*/*/*.rb", "spec/#{dir}/*/*.rb", "spec/#{dir}/*.rb"].each do |glob|
        Dir.glob(glob).each { |file| files << file }
      end
    end
    
    puts "- Found:"
    files.each { |f| puts "+ #{f}" }
    puts ""
    command = "#{binary} #{files.collect! { |f| File.expand_path(f) }.join(" ")} #{opts}"
  else
    file = "#{match[1]}.rb"

    puts ""
    puts "- File changed: #{file}"
    puts "- Running specs for: #{file}"
    puts ""
    
    command = "#{binary} spec/#{file} #{opts}"
  end
  
  system(command)
  
end
