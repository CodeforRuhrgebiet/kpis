require 'rubygems'
require 'mechanize'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'erb'
require 'yaml'
require 'colorize'
require 'twitter'
require 'logger'

project_root = File.expand_path('..', File.dirname(__FILE__))
Dir["#{project_root}/scripts/lib/*.rb"].each {|file| require file }

@@config = YAML.load_file("#{project_root}/config.yml")
script_start_time = Time.now

dc = DataCollector.new
dc.fetch!
dc.track!
# dc.save_to_file!

puts 'DONE!!! :)'.blue
script_end_time = Time.now
delta = script_end_time - script_start_time
puts "This operation took #{delta} seconds which are #{(delta / 60).round(2)} minutes.".light_cyan

exit
