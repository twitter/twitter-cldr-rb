require 'rubygems' unless ENV['NO_RUBYGEMS']

require 'rspec/core/rake_task'
require 'rubygems/package_task'

require 'rake/rdoctask' unless RUBY_VERSION >= '1.9.0'
require 'rdoc/task' unless RUBY_VERSION <= '1.9.0'

require 'digest'

spec = Gem::Specification.load("#{File.dirname(__FILE__)}/twitter_cldr.gemspec")

task :default => :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end

if RUBY_VERSION < '1.9.0'
  desc 'Run all examples with RCov'
  RSpec::Core::RakeTask.new('spec:rcov') do |t|
    t.rcov      = true
    t.pattern   = './spec/**/*_spec.rb'
    t.rcov_opts = %w(-T --sort coverage --exclude gems/,spec/)
  end
end

# Gem tasks
Gem::PackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the gem locally"
task :install => [:package] do
  sh %{gem install pkg/#{spec.name}-#{spec.version}}
end

