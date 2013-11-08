require 'rake'
require 'rake/testtask'

task :default => [:all]

desc "Run tests"
Rake::TestTask.new("all") do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/test_*.rb'
  t.verbose = true
  t.warning = true
end
