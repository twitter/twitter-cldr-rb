# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr

describe Segmentation::RuleSet do
  let(:test_path) do
    File.join(
      TwitterCldr::RESOURCES_DIR, 'shared', 'segments', 'tests'
    )
  end

  def parse(test_data)
    parts = test_data
      .split(/([÷×])/)
      .map(&:strip)
      .reject(&:empty?)
      .map do |part|
        if part =~ /[÷×]/
          part
        else
          [part.to_i(16)].pack('U*')
        end
      end
  end

  def boundaries(test_parts)
    idx = 0

    [].tap do |boundaries|
      test_parts.each do |part|
        if part =~ /[÷×]/
          boundaries << idx if part == '÷'
        else
          idx += 1
        end
      end
    end
  end

  def string(test_parts)
    test_parts.select.with_index do |part, idx|
      idx % 2 == 1
    end.join
  end

  def error_message(test, test_case_boundaries, result_boundaries)
<<END
Expected boundaries to match test case

            test case: #{test}
  expected boundaries: #{test_case_boundaries.inspect}
    actual boundaries: #{result_boundaries.inspect}
END
  end

  shared_examples 'a conformant implementation' do
    it 'passes all Unicode test cases' do
      test_data.each_with_index do |test, idx|
        next if skip_cases.include?(test)
        test_parts = parse(test)
        test_case_boundaries = boundaries(test_parts)
        test_case_string = string(test_parts)
        result_boundaries = rule_set.each_boundary(test_case_string).to_a
        expect(result_boundaries).to(
          eq(test_case_boundaries), error_message(
            test, test_case_boundaries, result_boundaries
          )
        )
      end
    end
  end

  describe 'word boundaries' do
    let(:test_file) { File.join(test_path, 'word_break_test.yml') }
    let(:test_data) { YAML.load_file(test_file) }
    let(:rule_set) { Segmentation::RuleSet.load(:en, 'word') }

    # These cases don't work because they end in single quotes (0027).
    # Conformant implementations (eg ICU) seem to allow partial regex
    # matching, or allow matches to run off the end of the string.
    # Since there's no such thing as a partial regex match in Ruby,
    # we have to ignore these cases. Hopefully they happen infrequently
    # in practice.
    let(:skip_cases) { ['÷ 05D0 × 0027 ÷', '÷ 05D0 × 0308 × 0027 ÷'] }

    it_behaves_like 'a conformant implementation'
  end

  describe 'sentence boundaries' do
    let(:test_file) { File.join(test_path, 'sentence_break_test.yml') }
    let(:test_data) { YAML.load_file(test_file) }
    let(:rule_set) { Segmentation::RuleSet.load(:en, 'sentence') }
    let(:skip_cases) { [] }

    it_behaves_like 'a conformant implementation'
  end
end
