# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'rubygems' unless ENV['NO_RUBYGEMS']

require 'bundler'
require 'digest'
require 'fileutils'
require 'rexml/document'

require 'rspec/core/rake_task'
require 'rubygems/package_task'

require './lib/twitter_cldr/js'

Bundler::GemHelper.install_tasks

task :default => :spec

desc 'Run specs'
task :spec => ["spec:ruby", "spec:js"]

desc 'Run Ruby specs'
RSpec::Core::RakeTask.new("spec:ruby") do |t|
  t.pattern = './spec/**/*_spec.rb'
end

desc 'Run JavaScript specs'
task "spec:js" => ["twitter_cldr:js:update"] do
  puts "\nJasmine Specs"
  failures = 0

  if `which jasmine-node`.strip.empty?
    puts "ERROR: You need to install jasmine-node to run JavaScript tests:"
    puts "  `npm install jasmine-node -g`"
    exit 1
  else
    puts `jasmine-node #{File.dirname(__FILE__)} --junitreport`
    doc_files = Dir.glob(File.join(File.dirname(__FILE__), "reports/**"))

    doc_files.each do |doc_file|
      doc = REXML::Document.new(File.read(doc_file))
      failures += doc.elements.to_a("testsuites/testsuite").inject(0) do |sum, element|
        sum += element.attributes["failures"].to_i
        sum
      end
    end

    if failures > 0
      exit 1
    end
  end
end

if RUBY_VERSION < '1.9.0'
  desc 'Run all examples with RCov'
  RSpec::Core::RakeTask.new('spec:rcov') do |t|
    t.rcov      = true
    t.pattern   = './spec/**/*_spec.rb'
    t.rcov_opts = %w(-T --sort coverage --exclude gems/,spec/)
  end
end

load "./lib/twitter_cldr/js/tasks/tasks.rake"
