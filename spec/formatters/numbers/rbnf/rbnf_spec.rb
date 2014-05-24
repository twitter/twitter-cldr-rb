# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters::Rbnf

TEST_FILE_DIR = File.join(File.dirname(__FILE__), "locales")

def test_file_for(locale)
  File.join(TEST_FILE_DIR, locale, "rbnf_test.yml")
end

failures = {}

describe RbnfFormatter do
  def allowed_failures
    @allowed_failures ||= begin
      YAML.load_file(
        File.join(File.dirname(__FILE__), "allowed_failures.yml")
      )
    end
  end

  def allowed_failure?(options = {})
    trail = [:locale, :group, :rule_set]
    dest = trail.inject(allowed_failures) do |ret, leg|
      if ret && ret[options[leg]]
        ret[options[leg]]
      else
        ret
      end
    end

    if dest
      dest.include?(options[:number])
    else
      false
    end
  end

  TwitterCldr.supported_locales.each do |locale|
    formatter = RbnfFormatter.new(locale)
    test_data = YAML.load_file(test_file_for(locale.to_s))

    describe locale.localize.as_language_code do
      formatter.group_names.each do |group_name|

        describe group_name do
          formatter.rule_set_names_for_group(group_name).each do |rule_set_name|

            describe rule_set_name.gsub("-", " ") do

              # running basic test suite only runs spellout-numbering tests (for speed)
              it "formats correctly", :slow => rule_set_name != "spellout-numbering" do
                test_data[group_name][rule_set_name].each_pair do |number, expected|
                  got = formatter.format(number, {
                    :rule_group => group_name,
                    :rule_set => rule_set_name
                  })

                  if got != expected
                    opts = {
                      :locale => locale, :group => group_name,
                      :rule_set => rule_set_name, :number => number
                    }

                    unless allowed_failure?(opts)
                      failures[locale] ||= {}
                      failures[locale][group_name] ||= {}
                      failures[locale][group_name][rule_set_name] ||= []
                      failures[locale][group_name][rule_set_name] << number
                      expect(got).to eq(expected)
                    end
                  else
                    expect(got).to eq(expected)
                  end

                end
              end

            end
          end
        end
      end
    end
  end

  after(:all) do
    if failures.size > 0
      puts "\nFailure hash:"
      puts failures.inspect
    end
  end

end