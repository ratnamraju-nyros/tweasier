#!/usr/bin/env ruby

load File.dirname(__FILE__) + "/../.irbrc"
enable_street_view

g = new_geo
a = g.locate(*ARGV).first

require "tempfile"

p = File.expand_path "google-geo-streetview.html"

File.open(p, "w") do |f|
  html = a.street_view_html(
    :id    => "TEST",
    :style => "width:640px; height:480px"
  )
  f.puts html
end

raise "wtf" and exit unless File.exist? p

require "rubygems"
require "launchy"
Launchy::Browser.run "file://#{p}"

puts "created test file at #{p}"
