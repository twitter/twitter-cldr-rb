# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe 'Unicode collation tailoring' do

  # Test data is taken from http://unicode.org/cldr/trac/browser/tags/release-2-0-1/test/
  # Test files format: # - comments, // - pending tests.
  #
  it 'passes tailoring test for each supported locale', :slow => true do
    TwitterCldr.supported_locales.each do |locale|
      collator = Collator.new(locale)

      print "#{locale}\t-\t"

      lines = open(File.join(File.dirname(__FILE__), 'tailoring_tests', "#{locale}.txt")) { |f| f.lines.map(&:strip) }

      active_tests  = lines.count(&method(:tailoring_test?))
      pending_tests = lines.count(&method(:pending_tailoring_test?))
      print "tests:  %-4d active, %5.1f%% %5s pending\t-\t" % [active_tests, (100.0 * pending_tests / (pending_tests + active_tests)), "(#{pending_tests})"]

      last_number = last = nil

      failures = lines.each_with_index.inject([]) do |memo, (current, number)|
        if tailoring_test?(current)
          memo << [last_number + 1, last, current] if tailoring_test?(last) && collator.compare(last, current) == 1

          last = current
          last_number = number
        elsif pending_tailoring_test?(current)
          last_number = last = nil
        end

        memo
      end

      if failures.empty?
        puts "OK"
      else
        failures_info = "#{failures.size} failures: #{failures.inspect}"

        puts failures_info
        failures.should(be_empty, "#{locale} - #{failures_info}")
      end
    end
  end

  def pending_tailoring_test?(line)
    !!(line =~ %r{^//})
  end

  def tailoring_test?(line)
    !!(line && line !~ %r{^(//|#|\s*$)})
  end

end
