README = File.readlines "#{File.dirname __FILE__}/README.textile"

require "echoe"

class Echoe
  def honor_gitignore!
    self.ignore_pattern = \
      Dir["**/.gitignore"].inject([]) do |pattern,gitignore| 
        pattern.concat \
          File.readlines(gitignore).
            map    { |line| line.strip }.
            reject { |line| "" == line }.
            map    { |glob| 
              d = File.dirname(gitignore)
              d == "." ? glob : File.join(d, glob)
            }
      end.flatten.uniq
  end
end

SPEC = Echoe.new "google-geo" do |p|
  p.author  = "Seth Thomas Rasmussen"
  p.email   = "sethrasmussen@gmail.com"
  p.url     = "http://github.com/greatseth/google-geo"
  p.summary = README[2]
  p.honor_gitignore!
end

task :debug_spec do
  require 'yaml'
  y SPEC.to_yaml
end
