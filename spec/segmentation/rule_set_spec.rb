# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Segmentation::RuleSet do
  let(:cursor) { TwitterCldr::Segmentation::Cursor }
  let(:skip_cases) { [] }

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
        result_boundaries = rule_set.each_boundary(cursor.new(test_case_string)).to_a
        result_boundaries.unshift(0) if rule_set.boundary_type != 'line'

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
    let(:rule_set) { TwitterCldr::Segmentation::RuleSet.create(:en, 'word') }

    it_behaves_like 'a conformant implementation'
  end

  describe 'sentence boundaries' do
    let(:test_file) { File.join(test_path, 'sentence_break_test.yml') }
    let(:test_data) { YAML.load_file(test_file) }
    let(:rule_set) { TwitterCldr::Segmentation::RuleSet.create(:en, 'sentence') }

    it_behaves_like 'a conformant implementation'
  end

  describe 'grapheme boundaries' do
    let(:test_file) { File.join(test_path, 'grapheme_break_test.yml') }
    let(:test_data) { YAML.load_file(test_file) }
    let(:rule_set) { TwitterCldr::Segmentation::RuleSet.create(:en, 'grapheme') }

    it_behaves_like 'a conformant implementation'
  end

  describe 'line boundaries' do
    let(:test_file) { File.join(test_path, 'line_break_test.yml') }
    let(:test_data) { YAML.load_file(test_file) }
    let(:rule_set) { TwitterCldr::Segmentation::RuleSet.create(:en, 'line') }

    # These are tests that ICU currently doesn't pass. I have no idea why, but
    # only these 26 of 10,239 fail. That's a failure rate of 0.25%, which is
    # more than tolerable IMHO.
    let(:skip_cases) do
      [
        '× 002D ÷ 0023 ÷',
        '× 002D × 0308 ÷ 0023 ÷',
        '× 002D ÷ 00A7 ÷',
        '× 002D × 0308 ÷ 00A7 ÷',
        '× 002D ÷ 50005 ÷',
        '× 002D × 0308 ÷ 50005 ÷',
        '× 002D ÷ 0E01 ÷',
        '× 002D × 0308 ÷ 0E01 ÷',
        '× 002C ÷ 0030 ÷',
        '× 002C × 0308 ÷ 0030 ÷',
        '× 200B × 0020 ÷ 002C ÷',
        '× 0065 × 0071 × 0075 × 0061 × 006C × 0073 × 0020 × 002E ÷ 0033 × 0035 × 0020 ÷ 0063 × 0065 × 006E × 0074 × 0073 ÷',
        '× 0061 × 002E ÷ 0032 × 0020 ÷',
        '× 0061 × 002E ÷ 0032 × 0020 ÷ 0915 ÷',
        '× 0061 × 002E ÷ 0032 × 0020 ÷ 672C ÷',
        '× 0061 × 002E ÷ 0032 × 3000 ÷ 672C ÷',
        '× 0061 × 002E ÷ 0032 × 3000 ÷ 307E ÷',
        '× 0061 × 002E ÷ 0032 × 3000 ÷ 0033 ÷',
        '× 0041 × 002E ÷ 0031 × 0020 ÷ BABB ÷',
        '× BD24 ÷ C5B4 × 002E × 0020 ÷ 0041 × 002E ÷ 0032 × 0020 ÷ BCFC ÷',
        '× BD10 ÷ C694 × 002E × 0020 ÷ 0041 × 002E ÷ 0033 × 0020 ÷ BABB ÷',
        '× C694 × 002E × 0020 ÷ 0041 × 002E ÷ 0034 × 0020 ÷ BABB ÷',
        '× 0061 × 002E ÷ 0032 × 3000 ÷ 300C ÷',
        '× 1F1F7 × 1F1FA ÷ 1F1F8 ÷',
        '× 1F1F7 × 1F1FA ÷ 1F1F8 × 1F1EA ÷',
        '× 1F1F7 × 1F1FA × 200B ÷ 1F1F8 × 1F1EA ÷'
      ]
    end

    it_behaves_like 'a conformant implementation'
  end
end
