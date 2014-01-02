# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters::Rbnf

TEST_FILE_DIR = File.join(File.dirname(__FILE__), "locales")

def test_file_for(locale)
  File.join(TEST_FILE_DIR, locale, "rbnf_test.yml")
end

# [{ :locale =>:group => "SpelloutRules" }]

describe RbnfFormatter do
  TwitterCldr.supported_locales.each do |locale|
  # [:nl].each do |locale|
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
                  # puts number
                  got = formatter.format(number, {
                    :rule_group => group_name,
                    :rule_set => rule_set_name
                  })

                  # got.should match_normalized(expected)
                  got.should == expected
                end
              end

            end
          end
        end
      end
    end
  end
end
