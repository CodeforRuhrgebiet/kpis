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
require 'git'

def autocommit?
  ARGV[0] == "autocommit" ? true : false
end

project_root = File.expand_path('..', File.dirname(__FILE__))
Dir["#{project_root}/scripts/lib/*.rb"].each {|file| require file }

@@config = YAML.load_file("#{project_root}/config.yml")
script_start_time = Time.now

# dc = DataCollector.new
# dc.fetch!
# dc.save_to_file!

puts 'DONE!!! :)'.blue
script_end_time = Time.now
delta = script_end_time - script_start_time
puts "This operation took #{delta} seconds which are #{(delta / 60).round(2)} minutes.".light_cyan

if autocommit?
  puts 'Publishing..'.yellow

  # g = Git.open(project_root, log: Logger.new(STDOUT))
  # puts g.repo
  # g.config('user.name', 'Martin Schurig')
  # g.config('user.email', 'martin@schurig.pw')

  res = system( "cd #{project_root} && git add --all && git push origin master" )
  puts res
  # puts g.status
  # g.add(all: true)
  # g.commit_all('update kpis')
  # g.push
  puts 'Published!!! :)'.blue
end

exit
