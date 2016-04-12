require 'rubygems'
require 'git'

project_root = File.expand_path('..', File.dirname(__FILE__))
Dir["#{project_root}/scripts/lib/*.rb"].each {|file| require file }

g = Git.open(project_root, log: Logger.new(STDOUT))
g.reset_hard(g.branches[:master].gcommit)
g.pull(g.repo, g.branches[:master])

exit
