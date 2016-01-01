# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'rubygems' unless ENV['NO_RUBYGEMS']

require 'bundler'
require 'digest'

require 'rspec/core/rake_task'
require 'rubygems/package_task'

require './lib/twitter_cldr'

require 'pry-nav'

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

namespace :spec do
  desc 'Run specs with SimpleCov'
  task :cov => ['spec:simplecov_env', :spec] do
    require 'launchy'
    Launchy.open 'coverage/index.html'
  end

  desc 'Run full specs suit with SimpleCov'
  task 'cov:full' => %w[spec:full_spec_env spec:cov]

  task :simplecov_env do
    puts 'Cleaning up coverage reports'
    rm_rf 'coverage'

    ENV['SCOV'] = 'true'
  end
end

task :update do
  tasks = if RUBY_PLATFORM == 'java'
    # these should be run using JRuby 1.7 in 1.9 mode, ICU4J v51.2, and CLDR v23.1 (v24 collation rules syntax is not supported yet)
    [
      "update:tailoring_data",  # per locale
      "update:collation_tries", # per locale, must come after update:tailoring_data
      "update:rbnf_tests",      # per locale
      "update:bidi_tests"
    ]
  else
    puts "You might also want to run this rake task using JRuby 1.7 (in 1.9 mode) to update collation data and RBNF tests."

    [
      "update:locales_resources",      # per locale (+ units resources using different CLDR and ruby-cldr, see LocalesResourcesImporter)
      "update:unicode_data",
      "update:unicode_properties",
      "update:unicode_property_aliases",
      "update:generate_casefolder",    # must come after unicode data
      "update:postal_codes",
      "update:phone_codes",
      "update:language_codes",
      "update:segment_exceptions",     # per locale
      "update:segment_tests",
      "update:readme"
    ]
  end

  tasks.each do |task|
    puts "Executing #{task}"
    Rake::Task[task].invoke
  end
end

# TODO: 'add_locale' task that creates a new directory and runs all necessary 'update' tasks (+ suggests to run those that depend on JRuby)

namespace :update do
  ICU_JAR = './vendor/icu4j.jar'

  desc 'Import locales resources'
  task :locales_resources, :cldr_path do |_, args|
    TwitterCldr::Resources::LocalesResourcesImporter.new(
      args[:cldr_path] || './vendor/cldr',
      './resources'
    ).import
  end

  desc 'Import custom locales resources'
  task :custom_locales_resources do
    TwitterCldr::Resources::CustomLocalesResourcesImporter.new(
      './resources/custom/locales'
    ).import
  end

  desc 'Import tailoring resources from CLDR data (should be executed using JRuby 1.7 in 1.9 mode)'
  task :tailoring_data, :cldr_path, :icu4j_jar_path do |_, args|
    TwitterCldr::Resources::TailoringImporter.new(
      args[:cldr_path] || './vendor/cldr',
      './resources/collation/tailoring',
      args[:icu4j_jar_path] || ICU_JAR
    ).import(TwitterCldr.supported_locales)
  end

  desc 'Import Unicode data resources'
  task :unicode_data, :unicode_data_path do |_, args|
    TwitterCldr::Resources::UnicodeDataImporter.new(
      args[:unicode_data_path] || './vendor/unicode-data',
      './resources/unicode_data'
    ).import
  end

  desc 'Import Unicode property resources'
  task :unicode_properties, :properties_path do |_, args|
    TwitterCldr::Resources::Properties::PropertiesImporter.new(
      args[:properties_path] || './vendor/unicode-data/properties',
      './resources/unicode_data/properties'
    ).import
  end

  desc 'Import unicode property value aliases'
  task :unicode_property_aliases, :property_aliases_path do |_, args|
    TwitterCldr::Resources::UnicodePropertyAliasesImporter.new(
      args[:property_aliases_path] || './vendor/unicode-data',
      './resources/unicode_data'
    ).import
  end

  desc 'Generate the casefolder class. Depends on unicode data'
  task :generate_casefolder do
    TwitterCldr::Resources::CasefolderClassGenerator.new(
      './lib/twitter_cldr/resources/casefolder.rb.erb',
      './lib/twitter_cldr/shared'
    ).generate
  end

  desc 'Import postal codes resource'
  task :postal_codes do
    TwitterCldr::Resources::PostalCodesImporter.new(
      './resources/shared'
    ).import
  end

  desc 'Import phone codes resource'
  task :phone_codes, :cldr_path do |_, args|
    TwitterCldr::Resources::PhoneCodesImporter.new(
      args[:cldr_path] || './vendor/cldr',
      './resources/shared'
    ).import
  end

  desc 'Import language codes'
  task :language_codes, :language_codes_data do |_, args|
    TwitterCldr::Resources::LanguageCodesImporter.new(
      args[:language_codes_data] || './vendor/language-codes',
      './resources/shared'
    ).import
  end

  desc 'Update default and tailoring tries dumps (should be executed using JRuby 1.7 in 1.9 mode)'
  task :collation_tries do
    TwitterCldr::Resources::CollationTriesDumper.update_dumps
  end

  desc 'Import normalization quick check data'
  task :normalization_quick_check do
    TwitterCldr::Resources::NormalizationQuickCheckImporter.new(
      './vendor',
      './resources/unicode_data'
    ).import
  end

  desc 'Import (generate) bidi tests (should be executed using JRuby 1.7 in 1.9 mode)'
  task :bidi_tests do |_, args|
    TwitterCldr::Resources::BidiTestImporter.new(
      './spec/bidi'
    ).import
  end

  desc 'Import (generate) rule-based number format tests (should be executed using JRuby 1.7 in 1.9 mode)'
  task :rbnf_tests, :icu4j_jar_path do |_, args|
    TwitterCldr::Resources::RbnfTestImporter.new(
      './spec/formatters/numbers/rbnf/locales',
      args[:icu4j_jar_path] || ICU_JAR
    ).import(TwitterCldr.supported_locales)
  end

  desc 'Import segment exceptions'
  task :segment_exceptions do
    TwitterCldr::Resources::Uli::SegmentExceptionsImporter.new(
      './vendor/uli/segments',
      './resources/uli/segments'
    ).import([:de, :en, :es, :fr, :it, :pt, :ru])  # only locales ULI supports at the moment
  end

  desc 'Import segment tests'
  task :segment_tests do
    TwitterCldr::Resources::SegmentTestsImporter.new(
      './vendor/unicode-data/segments',
      './resources/shared/segments/tests'
    ).import
  end

  desc 'Update README'
  task :readme do |_, args|
    renderer = TwitterCldr::Resources::ReadmeRenderer.new(
      File.read("./README.md.erb")
    )

    File.open("./README.md", "w+") do |f|
      f.write(renderer.render)
    end

    if renderer.assertion_failures.size > 0
      puts "There were errors encountered while updating the README. Please run specs for details"
    end
  end
end
