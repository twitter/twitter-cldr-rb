# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'rubygems' unless ENV['NO_RUBYGEMS']

require 'bundler'
require 'digest'

require 'rspec/core/rake_task'
require 'rubygems/package_task'

require './lib/twitter_cldr'

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

    desc 'Import locales resources'
    task :locales_resources, :cldr_path do |_, args|
      TwitterCldr::Resources::LocalesResourcesImporter.new(
          args[:cldr_path] || '../cldr',
          './resources/locales'
      ).import
    end

    desc 'Import custom locales resources'
    task :custom_locales_resources do
      TwitterCldr::Resources::CustomLocalesResourcesImporter.new('./resources/custom/locales').import
    end

    desc 'Import tailoring resources from CLDR data (should be executed using JRuby 1.7 in 1.9 mode)'
    task :tailoring, :cldr_path, :icu4j_jar_path do |_, args|
      TwitterCldr::Resources::TailoringImporter.new(
          args[:cldr_path] || '../cldr',
          './resources/collation/tailoring',
          args[:icu4j_jar_path] ||'../icu4j-49_1.jar'
      ).import(TwitterCldr.supported_locales)
    end

    desc 'Import Unicode data resources'
    task :unicode_data, :unicode_data_path do |_, args|
      TwitterCldr::Resources::UnicodeDataImporter.new(
          args[:unicode_data_path] || '../unicode-data',
          './resources/unicode_data'
      ).import
    end

    desc 'Import composition exclusions resource'
    task :composition_exclusions, :derived_normalization_props_path do |_, args|
      TwitterCldr::Resources::CompositionExclusionsImporter.new(
          args[:derived_normalization_props_path] || '../unicode-data/DerivedNormalizationProps.txt',
          './resources/unicode_data'
      ).import
    end

    desc 'Import postal codes resource'
    task :postal_codes, :cldr_path do |_, args|
      TwitterCldr::Resources::PostalCodesImporter.new(
          args[:cldr_path] || '../cldr',
          './resources/shared'
      ).import
    end

    desc 'Import phone codes resource'
    task :phone_codes, :cldr_path do |_, args|
      TwitterCldr::Resources::PhoneCodesImporter.new(
          args[:cldr_path] || '../cldr',
          './resources/shared'
      ).import
    end

    desc 'Import language codes'
    task :language_codes, :language_codes_data do |_, args|
      TwitterCldr::Resources::LanguageCodesImporter.new(
          args[:language_codes_data] || '../language-codes',
          './resources/shared'
      ).import
    end

    desc 'Update default and tailoring tries dumps'
    task :tries do
      TwitterCldr::Resources::TriesDumper.update_dumps
    end

    desc 'Update canonical compositions resource'
    task :canonical_compositions do
      TwitterCldr::Resources::CanonicalCompositionsUpdater.new('./resources/unicode_data').update
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