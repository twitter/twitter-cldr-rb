require 'rubygems' unless ENV['NO_RUBYGEMS']

require 'rspec/core/rake_task'
require 'rubygems/package_task'

require 'bundler'
require 'digest'

Bundler::GemHelper.install_tasks

task :default => :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end

task :test_js do
  require File.expand_path(File.join(File.dirname(__FILE__), %w[lib twitter_cldr]))
  TwitterCldr.require_js
  TwitterCldr::Js.run_tests
end

if RUBY_VERSION < '1.9.0'
  desc 'Run all examples with RCov'
  RSpec::Core::RakeTask.new('spec:rcov') do |t|
    t.rcov      = true
    t.pattern   = './spec/**/*_spec.rb'
    t.rcov_opts = %w(-T --sort coverage --exclude gems/,spec/)
  end
end
