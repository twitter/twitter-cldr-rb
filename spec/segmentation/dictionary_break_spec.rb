# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Segmentation::BreakIterator do
  base_path = File.join(
    TwitterCldr::RESOURCES_DIR, *%w(shared segments tests dictionary_tests)
  )

  test_files_pattern = File.join(base_path, '*.yml')
  test_files = Dir.glob(test_files_pattern)
  test_files.reject! { |f| f.end_with?('combined.yml') }

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

  it 'correctly segments a combined text sample' do
    test_data = YAML.load_file(File.join(base_path, 'combined.yml'))
    iterator = described_class.new(test_data[:locale])
    actual_segments = iterator.each_word(test_data[:text]).map { |word, *| word }
    expect(actual_segments).to eq(test_data[:segments])
  end
end
