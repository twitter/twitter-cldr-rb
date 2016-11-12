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

task default: :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end

namespace :spec do
  desc 'Run full specs suit'
  task full: [:full_spec_env, :spec]

  task :full_spec_env do
    ENV['FULL_SPEC'] = 'true'
  end
end

namespace :spec do
  desc 'Run specs with SimpleCov'
  task cov: ['spec:simplecov_env', :spec] do
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
  klasses = TwitterCldr::Resources.importer_classes_for_ruby_engine
  TwitterCldr::Resources::ImportResolver.new(klasses).import
end

task :add_locale, :locale do |_, args|
  klasses = TwitterCldr::Resources.locale_based_importer_classes_for_ruby_engine
  instances = klasses.map { |klass| klass.new(locales: [args[:locale]]) }
  TwitterCldr::Resources::ImportResolver.new(instances).import
end

# add_locale and update_locale do the same thing
task :update_locale, [:locale] => :add_locale

namespace :update do
  desc 'Import locales resources'
  task :locales_resources do
    TwitterCldr::Resources::LocalesResourcesImporter.new.import
  end

  desc 'Import tailoring resources from CLDR data (should be executed using JRuby 1.7 in 1.9 mode)'
  task :tailoring_data do
    TwitterCldr::Resources::TailoringImporter.new.import
  end

  desc 'Import Unicode data resources'
  task :unicode_data do
    TwitterCldr::Resources::UnicodeDataImporter.new.import
  end

  desc 'Import Unicode property resources'
  task :unicode_properties do
    TwitterCldr::Resources::property_importer_classes.each do |klass|
      klass.new.import
    end
  end

  desc 'Import unicode property value aliases'
  task :unicode_property_aliases do
    TwitterCldr::Resources::UnicodePropertyAliasesImporter.new.import
  end

  desc 'Generate the casefolder class. Depends on unicode data'
  task :casefolder do
    TwitterCldr::Resources::CasefolderClassGenerator.new.import
  end

  desc 'Import postal codes resource'
  task :postal_codes do
    TwitterCldr::Resources::PostalCodesImporter.new.import
  end

  desc 'Import phone codes resource'
  task :phone_codes do
    TwitterCldr::Resources::PhoneCodesImporter.new.import
  end

  desc 'Import language codes'
  task :language_codes do
    TwitterCldr::Resources::LanguageCodesImporter.new.import
  end

  desc 'Update default and tailoring tries dumps (should be executed using JRuby 1.7 in 1.9 mode)'
  task :collation_tries do
    TwitterCldr::Resources::CollationTriesImporter.new.import
  end

  desc 'Import (generate) bidi tests (should be executed using JRuby 1.7 in 1.9 mode)'
  task :bidi_tests do
    TwitterCldr::Resources::BidiTestImporter.new.import
  end

  desc 'Import (generate) rule-based number format tests (should be executed using JRuby 1.7 in 1.9 mode)'
  task :rbnf_tests do
    TwitterCldr::Resources::RbnfTestImporter.new.import
  end

  desc 'Import (generate) transformation tests (should be executed using JRuby 1.7 in 1.9 mode)'
  task :transform_tests do
    TwitterCldr::Resources::TransformTestImporter.new.import
  end

  desc 'Import segment exceptions'
  task :segment_exceptions do
    TwitterCldr::Resources::Uli::SegmentExceptionsImporter.new.import
  end

  desc 'Import segment tests'
  task :segment_tests do
    TwitterCldr::Resources::SegmentTestsImporter.new.import
  end

  desc 'Import hyphenation dictionaries'
  task :hyphenation_dictionaries do
    TwitterCldr::Resources::HyphenationImporter.new.import
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
