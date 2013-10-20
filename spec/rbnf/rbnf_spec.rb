# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'
require 'pry-nav'

include TwitterCldr::Formatters

# $failure_count = 0
# $total = 0

TEST_FILE_DIR = File.join(File.dirname(__FILE__), "locales")

def test_file_for(locale)
  File.join(TEST_FILE_DIR, locale, "rbnf_test.yml")
end

describe RuleBasedNumberFormatter do
  # after(:all) do
  #   puts "#{(($failure_count / $total.to_f) * 100).round}% failed"
  # end

  # TwitterCldr.supported_locales.each do |locale|
  [:en].each do |locale|
    locale_namespace = RuleBasedNumberFormatter.for_locale(locale)

    describe locale_namespace do
      locale_namespace.constants.each do |ruleset_sym|
        ruleset_klass = locale_namespace.const_get(ruleset_sym)

        describe ruleset_klass do
          describe "#{locale_namespace.name.split("::").last} #{ruleset_sym.downcase} numbers" do

            failure_count = 0
            test_data = YAML.load_file(test_file_for(locale.to_s))

            test_data[ruleset_sym.to_s.downcase].each_pair do |ruleset_name, test_cases|
              method = TwitterCldr::Resources::Rbnf::RuleSet.get_safe_renderer_name(ruleset_name)

              describe "##{method}" do
                it "formats correctly" do

                  test_cases.each_pair do |number, expected|
                    if ruleset_klass.respond_to?(method.to_sym)
                      got = ruleset_klass.send(method.to_sym, number)
                      failure_count += 1 unless got == expected
                      got.should == expected
                    end
                  end

                end
              end
            end

            total = test_data[ruleset_sym.to_s.downcase].inject(0) { |ret, (ruleset_name, test_cases)| ret + test_cases.size }
            percent = ((failure_count / total.to_f) * 100).round
            puts "#{failure_count} failures of #{total} total, #{percent}%"

          end
        end
      end
    end
  end
end
