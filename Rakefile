# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'rubygems' unless ENV['NO_RUBYGEMS']

require 'bundler'
require 'digest'

require 'rspec/core/rake_task'
require 'rubygems/package_task'

Bundler::GemHelper.install_tasks

task :default => :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end

namespace :spec do
  desc 'Run full specs suit'
  task :full => [:full_spec_env, :spec]

  task :full_spec_env do
    ENV['FULL_SPEC'] = 'true'
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

namespace :resources do
  namespace :update do
    desc 'Import tailoring resources from CLDR data (should be executed using JRuby 1.7 in 1.9 mode)'
    task :tailoring do
      require './lib/twitter_cldr'

      importer = TwitterCldr::Resources::Import::Tailoring.new(
          ENV.fetch('CLDR_DATA_PATH', '../cldr-tailoring/'),
          './resources/collation/tailoring',
          ENV.fetch('ICU4J_JAR_PATH', '../icu4j-49_1.jar')
      )

      TwitterCldr.supported_locales.each { |locale| importer.import(locale) }
    end
  end
end

namespace :js do
  task :build do
    require File.expand_path(File.join(File.dirname(__FILE__), %w[lib twitter_cldr]))
    TwitterCldr.require_js
    FileUtils.mkdir_p(TwitterCldr::Js.build_dir)
    TwitterCldr::Js.output_dir = File.expand_path(ENV["OUTPUT_DIR"])
    TwitterCldr::Js.make(:locales => TwitterCldr.supported_locales)
    TwitterCldr::Js.install
  end

  task :test do
    require File.expand_path(File.join(File.dirname(__FILE__), %w[lib twitter_cldr]))
    TwitterCldr.require_js
    FileUtils.mkdir_p(TwitterCldr::Js.build_dir)
    TwitterCldr::Js.make(:locales => [:en])
    puts "Running JavaScript tests (Jasmine)..."
    TwitterCldr::Js.test
    FileUtils.rm_rf(TwitterCldr::Js.build_dir)
    puts "\nRunning Ruby tests (RSpec)..."
    Dir.chdir(File.join(File.dirname(__FILE__), "js")) do
      Rake::Task["spec"].execute
    end
  end
end