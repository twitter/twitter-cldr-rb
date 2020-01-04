# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Segmentation::BreakIterator do
  test_files_pattern = File.join(
    TwitterCldr::RESOURCES_DIR, *%w(shared segments tests dictionary_tests *.yml)
  )

  test_files = Dir.glob(test_files_pattern)

  test_files.each do |test_file|
    test_data = YAML.load_file(test_file)
    locale = test_data[:locale].to_sym
    text = test_data[:text]
    expected_segments = test_data[:segments]

    locale_name = if locale == :my
      'Burmese'
    else
      (locale.localize.as_language_code || locale).split(',').first
    end

    it "correctly segments text in #{locale_name} by word" do
      iterator = described_class.new(locale)
      actual_segments = iterator.each_word(text).map { |word, *| word }
      expect(actual_segments).to eq(expected_segments)
    end
  end
end
