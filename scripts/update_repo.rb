require 'rubygems'
require 'git'
require 'logger'

project_root = File.expand_path('..', File.dirname(__FILE__))

g = Git.open(project_root, log: Logger.new(STDOUT))
g.reset_hard(g.branches[:master].gcommit)
g.pull(g.repo, g.branches[:master])

exit
