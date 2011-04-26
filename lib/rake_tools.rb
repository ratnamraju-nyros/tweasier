module Rake
  module Tools
    # -------------------------------------------------------------
    # A bunch of utility methods to use in rake tasks
    # -------------------------------------------------------------
    
    def error(text)
      puts "\033[1;31m#{text}\033[0m"
    end

    def success(text)
      puts "\033[1;32m#{text}\033[0m"
    end

    def note(text)
      puts "\033[1;36m#{text}\033[0m"
    end
    
    def quote(text)
      puts "  \033[1;33m#{text}\033[0m"
    end
    
    def breaker
      puts "\n"
    end
    
  end
end