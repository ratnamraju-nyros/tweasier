# Tweasier library written by Josh Nesbitt <josh@josh-nesbitt.net>

module Tweasier
  
  def self.logger(text, opts={})
    @logger ||= begin
      logfile   = File.join(Rails.root, "log", "tweasier_#{Rails.env}.log")
      log       = Logger.new(logfile)
      log.level = Logger::DEBUG
      log
    end
    
    out = "[Tweasier | #{Time.now.strftime("%A %d %B (at %H:%M%p)")}] #{text}"
    @logger.debug(out) rescue puts(out)
  end
end

Tweasier.logger "Initialised"
