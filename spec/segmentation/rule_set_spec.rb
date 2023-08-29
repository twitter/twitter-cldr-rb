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

  def error_messages(failures)
    messages = failures.map do |failure|
      error_message(
        failure[:test],
        failure[:test_case_boundaries],
        failure[:result_boundaries],
        failure[:icu_boundaries]
      )
    end

<<END
Expected boundaries to match test cases

#{messages.join("\n")}
END
  end

  def error_message(test, test_case_boundaries, result_boundaries, icu_boundaries)
<<END
             test case: #{test}
conformance boundaries: #{test_case_boundaries.inspect}
        ICU boundaries: #{icu_boundaries.inspect}
     actual boundaries: #{result_boundaries.inspect}
END
  end

  shared_examples 'a conformant implementation' do
    it 'passes all Unicode test cases, falling back to matching ICU test results' do
      failures = test_data.each_with_object([]).with_index do |(test, memo), idx|
        test_parts = parse(test)
        test_case_boundaries = boundaries(test_parts)
        test_case_string = string(test_parts)
        result_boundaries = iterator.each_boundary(test_case_string).to_a

        passed_conformance_test = result_boundaries == test_case_boundaries
        produced_same_results_as_icu = result_boundaries == icu_test_results[idx]

        if !passed_conformance_test && !produced_same_results_as_icu
          memo << {
            test: test,
            result_boundaries: result_boundaries,
            test_case_boundaries: test_case_boundaries,
            icu_boundaries: icu_test_results[idx]
          }
        end
      end

      expect(failures).to be_empty, error_messages(failures)
    end
  end

  describe 'word boundaries' do
    let(:test_file) { File.join(test_path, 'word_break_test.yml') }
    let(:icu_test_results_file) { File.join(test_path, 'icu_word_break_test_results.yml') }
    let(:test_data) { YAML.load_file(test_file) }
    let(:icu_test_results) { YAML.load_file(icu_test_results_file) }
    let(:iterator) { TwitterCldr::Segmentation::BreakIterator.iterator_for('word') }

    it_behaves_like 'a conformant implementation'
  end

  describe 'sentence boundaries' do
    let(:test_file) { File.join(test_path, 'sentence_break_test.yml') }
    let(:icu_test_results_file) { File.join(test_path, 'icu_sentence_break_test_results.yml') }
    let(:test_data) { YAML.load_file(test_file) }
    let(:icu_test_results) { YAML.load_file(icu_test_results_file) }
    let(:iterator) { TwitterCldr::Segmentation::BreakIterator.iterator_for('sentence') }

    it_behaves_like 'a conformant implementation'
  end

  describe 'grapheme boundaries' do
    let(:test_file) { File.join(test_path, 'grapheme_break_test.yml') }
    let(:icu_test_results_file) { File.join(test_path, 'icu_grapheme_break_test_results.yml') }
    let(:test_data) { YAML.load_file(test_file) }
    let(:icu_test_results) { YAML.load_file(icu_test_results_file) }
    let(:iterator) { TwitterCldr::Segmentation::BreakIterator.iterator_for('grapheme') }

    it_behaves_like 'a conformant implementation'
  end

  describe 'line boundaries' do
    let(:test_file) { File.join(test_path, 'line_break_test.yml') }
    let(:icu_test_results_file) { File.join(test_path, 'icu_line_break_test_results.yml') }
    let(:test_data) { YAML.load_file(test_file) }
    let(:icu_test_results) { YAML.load_file(icu_test_results_file) }
    let(:iterator) { TwitterCldr::Segmentation::BreakIterator.iterator_for('line') }

    it_behaves_like 'a conformant implementation'
  end
end
