require 'rubygems' unless ENV['NO_RUBYGEMS']

require 'rspec/core/rake_task'
require 'rubygems/package_task'
require File.join(File.dirname(__FILE__), "lib/version")

require 'bundler'
require 'digest'

Bundler::GemHelper.install_tasks

task :default => :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end

task :build_js do
  require File.expand_path(File.join(File.dirname(__FILE__), %w[lib twitter_cldr]))
  TwitterCldr.require_js
  FileUtils.mkdir_p(TwitterCldr::Js.build_dir)
  TwitterCldr::Js.output_dir = File.expand_path(ENV["OUTPUT_DIR"])
  TwitterCldr::Js.make(:locales => TwitterCldr.supported_locales)
  TwitterCldr::Js.install
end

task :test_js do
  require File.expand_path(File.join(File.dirname(__FILE__), %w[lib twitter_cldr]))
  TwitterCldr.require_js
  FileUtils.mkdir_p(TwitterCldr::Js.build_dir)
  TwitterCldr::Js.make(:locales => [:en])
  TwitterCldr::Js.test
  FileUtils.rm_rf(TwitterCldr::Js.build_dir)
end

if RUBY_VERSION < '1.9.0'
  desc 'Run all examples with RCov'
  RSpec::Core::RakeTask.new('spec:rcov') do |t|
    t.rcov      = true
    t.pattern   = './spec/**/*_spec.rb'
    t.rcov_opts = %w(-T --sort coverage --exclude gems/,spec/)
  end
end
