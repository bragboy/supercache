require "rubygems"
require "bundler/setup"
require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "appraisal"

RSpec::Core::RakeTask.new(:spec)

if !ENV["APPRAISAL_INITIALIZED"] && !ENV["TRAVIS"]
  task :default do
    system('bundle exec rake appraisal spec')
  end
  task :test do
    system('bundle exec rake appraisal spec')
  end
else
  task :default => :spec
  task :test => :spec
end
