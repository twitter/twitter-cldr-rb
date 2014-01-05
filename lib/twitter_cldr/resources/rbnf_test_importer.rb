# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'java'
require 'fileutils'
require 'twitter_cldr/resources/download'

module TwitterCldr
  module Resources

    # This class should be used with JRuby in 1.9 mode
    class RbnfTestImporter < IcuBasedImporter

      attr_reader :output_path, :icu4j_path

      # These don't have much of a pattern, just trying to get
      # a wide range of different possibilities.
      TEST_NUMBERS = [
        [-1_141, -1_142, -1_143],
        [-100, -75, -50, -24],
        (0..100),
        [321, 322, 323, 1_141, 1_142, 1_143, 10_311, 138_400]
        # [41.0, 5.22, 8.90, 555.1212, -14.90, -999.701]  # decimals really aren't supported yet
      ]

      def initialize(output_path, icu4j_path)
        @output_path = output_path
        @icu4j_path = icu4j_path
      end

      def import(locales)
        require_icu4j(icu4j_path)
        java_import 'com.ibm.icu.text.RuleBasedNumberFormat'
        java_import 'com.ibm.icu.util.ULocale'

        groupings = [
          RuleBasedNumberFormat::SPELLOUT,
          RuleBasedNumberFormat::ORDINAL,
          RuleBasedNumberFormat::DURATION
        ]

        import_locales(locales, groupings)
      end

      protected

      def import_locales(locales, groupings)
        locales.each do |locale|
          locale = locale.to_s
          ulocale = ULocale.new(locale)
          file = output_file_for(locale)
          FileUtils.mkdir_p(File.dirname(file))
          File.open(file, "w+") do |w|
            w.write(YAML.dump(import_locale(ulocale, groupings)))
          end
        end
      end

      def import_locale(ulocale, groupings)
        groupings.inject({}) do |grouping_ret, grouping|
          formatter = RuleBasedNumberFormat.new(ulocale, grouping)
          grouping_name = get_grouping_display_name(grouping)
          grouping_ret[grouping_name] = formatter.getRuleSetNames.inject({}) do |ruleset_ret, ruleset_name|
            ruleset_display_name = formatter.getRuleSetDisplayName(ruleset_name, ulocale)
            ruleset_display_name = clean_up_name(ruleset_display_name)
            ruleset_ret[ruleset_display_name] = import_ruleset(formatter, ruleset_name)
            ruleset_ret
          end
          grouping_ret
        end
      end

      def clean_up_name(name)
        name
          .gsub(/[^\w-]/, '-')
          .gsub('GREEKNUMERALMAJUSCULES', 'GreekNumeralMajuscules')
      end

      def import_ruleset(formatter, ruleset_name)
        TEST_NUMBERS.inject({}) do |ret, num_set|
          num_set.each do |num|
            ret[num] = formatter.format(num, ruleset_name)
          end
          ret
        end
      end

      def output_file_for(locale)
        File.join(output_path, locale, "rbnf_test.yml")
      end

      def get_grouping_display_name(grouping)
        case grouping
          when RuleBasedNumberFormat::SPELLOUT
            "SpelloutRules"
          when RuleBasedNumberFormat::ORDINAL
            "OrdinalRules"
          when RuleBasedNumberFormat::DURATION
            "DurationRules"
        end
      end

    end
  end
end
