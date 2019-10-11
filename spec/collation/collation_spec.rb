# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe 'Unicode Collation Algorithm' do

  SHORT_COLLATION_TEST_PATH = File.join(TwitterCldr::RESOURCES_DIR, 'collation', 'spec', 'CollationTest_CLDR_NON_IGNORABLE_SHORT.txt')
  FULL_COLLATION_TEST_PATH  = File.join(TwitterCldr::RESOURCES_DIR, 'collation', 'spec', 'CollationTest_CLDR_NON_IGNORABLE.txt')

  it 'passes all the tests in CollationTest_CLDR_NON_IGNORABLE_Short.txt' do
    run_test(SHORT_COLLATION_TEST_PATH)
  end

  it 'passes all the tests in CollationTest_CLDR_NON_IGNORABLE.txt', slow: true do
    run_test(FULL_COLLATION_TEST_PATH)
  end

  def run_test(file_path)
    collator = TwitterCldr::Collation::Collator.new

    previous_sort_key = previous_code_points = previous_str_code_points = nil

    File.open(file_path, 'r:utf-8') do |file|
      file.each do |line|
        next unless /^([0-9A-F ]+);/ =~ line

        current_str_code_points = $1.split
        current_code_points     = current_str_code_points.map(&:hex)

        current_sort_key = collator.get_sort_key(current_code_points)

        if previous_sort_key
          result = (previous_sort_key <=> current_sort_key).nonzero? || (previous_code_points <=> current_code_points)
          expect(result).to(eq(-1), error_message(previous_str_code_points, previous_sort_key, current_str_code_points, current_sort_key))
        end

        previous_sort_key        = current_sort_key
        previous_code_points     = current_code_points
        previous_str_code_points = current_str_code_points
      end
    end
  end

  # Generates a descriptive error message test failure.
  #
  def error_message(previous_code_points, previous_sort_key, current_code_points, current_sort_key)
<<END
Expected previous code points sequence to sort before the current one.

  previous:
    code points - #{previous_code_points.join(' ')}
    sort key    - #{pretty_sort_key(previous_sort_key)}
  current:
    code points - #{current_code_points.join(' ')}
    sort key    - #{pretty_sort_key(current_sort_key)}
END
  end

  def pretty_sort_key(current_sort_key)
    "[#{current_sort_key.map{ |byte| byte.to_s(16).upcase }.join(', ')}]"
  end

end
