# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

require 'open-uri'

include TwitterCldr::Normalization

describe 'Unicode Normalization Algorithms' do

  SHORT_NORMALIZATION_TEST_PATH = File.join(File.dirname(__FILE__), 'NormalizationTestShort.txt')
  FULL_NORMALIZATION_TEST_PATH  = File.join(File.dirname(__FILE__), 'NormalizationTest.txt')

  FULL_NORMALIZATION_TEST_URL = 'http://unicode.org/Public/UNIDATA/NormalizationTest.txt'

  shared_examples_for 'a normalization algorithm' do
    it 'passes all the tests in NormalizationTestShort.txt' do
      run_test(described_class, invariants, SHORT_NORMALIZATION_TEST_PATH)
    end

    it 'passes all the tests in NormalizationTest.txt', :slow => true do
      prepare_full_test
      run_test(described_class, invariants, FULL_NORMALIZATION_TEST_PATH)
    end
  end

  describe NFD do
    let(:invariants) { { 3 => [1, 2, 3], 5 => [4, 5] } }
    it_behaves_like 'a normalization algorithm'
  end

  describe NFKD do
    let(:invariants) { { 5 => [1, 2, 3, 4, 5] } }
    it_behaves_like 'a normalization algorithm'
  end

  describe NFC do
    let(:invariants) { { 2 => [1, 2, 3], 4 => [4, 5] } }
    it_behaves_like 'a normalization algorithm'
  end

  describe NFKC do
    let(:invariants) { { 4 => [1, 2, 3, 4, 5] } }
    it_behaves_like 'a normalization algorithm'
  end

  # Runs standard Unicode normalization tests from `file_path` for a given `normalizer`. Expected invariants are
  # specified via `invariants` hash.
  #
  # E.g., if `invariants` is { 2 => [1, 2, 3], 4 => [4, 5] } than the following invariants are expected to be true:
  #
  #   c2 == normalized(c1) == normalized(c2) == normalized(c3)
  #   c4 == normalized(c4) == normalized(c5)
  #
  # where (c1, c2,...) are columns of the normalization test separated by semicolons and normalized() is the
  # normalization function. Note, how expectation and tests columns indexes match the numbers in the `invariants` hash.
  #
  def run_test(normalizer, invariants, file_path)
    open(file_path, 'r:UTF-8') do |file|
      file.each do |line|
        next if line.empty? || line =~ /^(@|#)/

        data = line.split(';')[0...5].map { |cps| cps.split }

        invariants.each do |expected_index, tests|
          expected = data[expected_index - 1]

          tests.each do |test_index|
            test = data[test_index - 1]

            normalized = normalizer.normalize_code_points(test)

            message = error_message(line, test, expected, normalized, test_index, expected_index)
            normalized.should(eq(expected), message)
          end
        end
      end
    end
  end

  # Generates a descriptive error message test failure.
  #
  def error_message(line, test, expected, normalized, test_index, expected_index)
    <<-END
Test:       "#{line.strip}"
Invariant:  normalized(c#{test_index}) == c#{expected_index}
Expected:   normalized(#{test.inspect}) == #{expected.inspect}
Got:        #{normalized.inspect}
    END
  end

  # Downloads full version of the test if necessary.
  #
  def prepare_full_test
    return if File.file?(FULL_NORMALIZATION_TEST_PATH)

    print '    Downloading NormalizationTest.txt ... '
    open(FULL_NORMALIZATION_TEST_PATH, 'w') { |file| file.write(open(FULL_NORMALIZATION_TEST_URL).read) }
    puts 'done.'
  end

end