# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe 'Unicode collation tailoring' do

  describe 'tailoring support' do
    before(:each) do
      stub(Collator).default_fce_trie { TrieBuilder.parse_trie(fractional_uca_short_stub) }
      stub(TwitterCldr::Normalization::NFD).normalize_code_points { |code_points| code_points }
      stub(TwitterCldr).get_resource(:collation, :tailoring, locale) { YAML.load(tailoring_resource_stub) }
    end

    let(:locale)            { :some_locale }
    let(:default_collator)  { Collator.new }
    let(:tailored_collator) { Collator.new(locale) }

    describe 'tailoring rules support' do
      it 'tailored collation elements are used' do
        default_collator.get_collation_elements(%w[0490]).should  == [[0x5C1A, 5, 0x93], [0, 0xDBB9, 9]]
        tailored_collator.get_collation_elements(%w[0490]).should == [[0x5C1B, 5, 0x86]]

        default_collator.get_collation_elements(%w[0491]).should  == [[0x5C1A, 5, 9], [0, 0xDBB9, 9]]
        tailored_collator.get_collation_elements(%w[0491]).should == [[0x5C1B, 5, 5]]
      end

      it 'original contractions for tailored elements are applied' do
        default_collator.get_collation_elements(%w[0491 0306]).should  == [[0x5C, 0xDB, 9]]
        tailored_collator.get_collation_elements(%w[0491 0306]).should == [[0x5C, 0xDB, 9]]
      end
    end

    describe 'contractions suppressing support' do
      it 'suppressed contractions are ignored' do
        default_collator.get_collation_elements(%w[041A 0301]).should  == [[0x5CCC, 5, 0x8F]]
        tailored_collator.get_collation_elements(%w[041A 0301]).should == [[0x5C6C, 5, 0x8F], [0, 0x8D, 5]]
      end

      it 'non-suppressed contractions are used' do
        default_collator.get_collation_elements(%w[0415 0306]).should  == [[0x5C36, 5, 0x8F]]
        tailored_collator.get_collation_elements(%w[0415 0306]).should == [[0x5C36, 5, 0x8F]]
      end
    end
  end

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

  let(:fractional_uca_short_stub) do
<<END
# collation elements from default FCE table
0301; [, 8D, 05]
0306; [, 91, 05]
041A; [5C 6C, 05, 8F] # К
0413; [5C 1A, 05, 8F] # Г
0415; [5C 34, 05, 8F] # Е

# tailored (in UK locale) with "Г < ґ <<< Ґ"
0491; [5C 1A, 05, 09][, DB B9, 09] # ґ
0490; [5C 1A, 05, 93][, DB B9, 09] # Ґ

# contraction for a tailored collation element
0491 0306; [5C, DB, 09] # ґ̆

# contractions suppressed in tailoring (for RU locale)
041A 0301; [5C CC, 05, 8F] # Ќ
0413 0301; [5C 30, 05, 8F] # Ѓ

# contractions non-suppressed in tailoring
0415 0306; [5C 36, 05, 8F] # Ӗ
END
  end

  let(:tailoring_resource_stub) do
<<END
---
:tailored_table: ! '0491; [5C1B, 5, 5]

  0490; [5C1B, 5, 86]'
:suppressed_contractions: ГК
...
END
  end

end
