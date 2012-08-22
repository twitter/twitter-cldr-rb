# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'rubygems' unless ENV['NO_RUBYGEMS']

require 'bundler'
require 'digest'
require 'fileutils'

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
task "spec:js" do
  puts "\nJasmine Specs"
  puts `jasmine-node #{File.dirname(__FILE__)}`
end

if RUBY_VERSION < '1.9.0'
  desc 'Run all examples with RCov'
  RSpec::Core::RakeTask.new('spec:rcov') do |t|
    t.rcov      = true
    t.pattern   = './spec/**/*_spec.rb'
    t.rcov_opts = %w(-T --sort coverage --exclude gems/,spec/)
  end
end

task :update do
  output_dir = File.join(File.dirname(__FILE__), "lib/assets/javascripts/twitter_cldr")
  compiler = TwitterCldr::Js::Compiler.new

  { "min" => true, "full" => false }.each_pair do |dir, minify|
    compiler.compile_each(:minify => minify) do |bundle, locale|
      File.open(File.join(output_dir, dir, "twitter_cldr_#{locale}.js"), "w+") do |f|
        f.write(bundle)
      end
    end
  end
end

task :compile do
  compiler = TwitterCldr::Js::Compiler.new
  FileUtils.mkdir_p(ENV["OUTPUT_DIR"])

  { "twitter_cldr_%s.min.js" => true, "twitter_cldr_%s.js" => false }.each_pair do |file_pattern, minify|
    compiler.compile_each(:minify => minify) do |bundle, locale|
      File.open(File.join(ENV["OUTPUT_DIR"], file_pattern % locale), "w+") do |f|
        f.write(bundle)
      end
    end
  end
end
