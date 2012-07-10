# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'nokogiri'
require 'yaml'
require 'java'

module TwitterCldr
  module Resources
    module Import

      # This class should be used with JRuby 1.7 in 1.9 mode and ICU4J version 49.1 (available at
      # http://download.icu-project.org/files/icu4j/49.1/icu4j-49_1.jar).
      #
      class Tailoring

        SUPPORTED_RULES   = %w[p s t i pc sc tc ic x]
        SIMPLE_RULES      = %w[p s t i]
        LEVEL_RULE_REGEXP = /^(p|s|t|i)(c?)$/

        IGNORED_TAGS = %w[reset text #comment]

        LAST_BYTE_MASK = 0xFF

        LOCALES_MAP = {
            :'zh-Hant' => :'zh_Hant',
            :id => :root,
            :it => :root,
            :ms => :root,
            :nl => :root,
            :pt => :root
        }

        EMPTY_TAILORING_DATA = { 'tailored_table' => '', 'suppressed_contractions' => '' }

        class ImportError < RuntimeError; end

        # Arguments:
        #
        #   input_path  - path to a directory containing CLDR tailoring data (available at
        #                 http://unicode.org/cldr/trac/browser/tags/release-21/common/collation/
        #                 or as a part of CLDR release at http://cldr.unicode.org/index/downloads)
        #
        #   output_path - output directory for imported YAML files
        #
        #   icu4j_path  - path to ICU4J jar file
        #
        def initialize(input_path, output_path, icu4j_path)
          require icu4j_path

          @input_path  = input_path
          @output_path = output_path
        end

        def import(locale)
          print "Importing %8s\t--\t" % locale

          if tailoring_present?(locale)
            YAML.dump(tailoring_data(locale), open(resource_file_path(locale), 'w'))
            puts "Done."
          else
            YAML.dump(EMPTY_TAILORING_DATA, open(resource_file_path(locale), 'w'))
            puts "Missing (generated empty tailoring resource)."
          end
        rescue ImportError => e
          puts "Error: #{e.message}"
        end

        private

        def tailoring_present?(locale)
          File.file?(locale_file_path(locale))
        end

        def translated_locale(locale)
          LOCALES_MAP.fetch(locale, locale)
        end

        def locale_file_path(locale)
          File.join(@input_path, "#{translated_locale(locale)}.xml")
        end

        def resource_file_path(locale)
          File.join(@output_path, "#{locale}.yml")
        end

        def tailoring_data(locale)
          doc = Nokogiri::XML(open(locale_file_path(locale)))
          collations = doc.at_xpath('//collations')

          collation_alias = collations.at_xpath('alias[@path="//ldml/collations"]')
          aliased_locale = collation_alias && collation_alias.attr('source')

          return tailoring_data(aliased_locale) if aliased_locale

          standard_tailoring = collations.at_xpath('collation[@type="standard"]')

          {
              'tailored_table'          => parse_tailorings(standard_tailoring, locale),
              'suppressed_contractions' => parse_suppressed_contractions(standard_tailoring)
          }
        end

        def parse_tailorings(data, locale)
          rules = data && data.at_xpath('rules')

          return '' unless rules

          collator = Java::ComIbmIcuText::Collator.get_instance(Java::JavaUtil::Locale.new(locale.to_s))

          rules.children.map do |child|
            validate_tailoring_rule(child)

            if child.name =~ LEVEL_RULE_REGEXP
              if $2.empty?
                table_entry_for_rule(collator, child.text)
              else
                child.text.chars.map { |char| table_entry_for_rule(collator, char) }
              end
            elsif child.name == 'x'
              context = ''
              child.children.each_with_object([]) do |c, memo|
                if SIMPLE_RULES.include?(c.name)
                  memo << table_entry_for_rule(collator, context + c.text)
                elsif c.name == 'context'
                  context = c.text
                elsif c.name != 'extend'
                  raise ImportError, "Rule '#{c.name}' inside <x></x> is not supported."
                end
              end
            else
              raise ImportError, "Tag '#{child.name}' is not supported." unless IGNORED_TAGS.include?(child.name)
            end
          end.flatten.compact.join("\n")
        end

        def table_entry_for_rule(collator, tailored_value)
          code_points = get_code_points(tailored_value)

          collation_elements = get_collation_elements(collator, tailored_value).map do |ce|
            ce.map { |l| l.to_s(16).upcase }.join(', ')
          end

          "#{code_points.join(' ')}; [#{collation_elements.join('][')}]"
        end

        def parse_suppressed_contractions(data)
          return '' unless data

          Array(data.xpath('suppress_contractions')).map do |contractions|
            Java::ComIbmIcuText::UnicodeSet.to_array(Java::ComIbmIcuText::UnicodeSet.new(contractions.text)).to_a
          end.flatten.join
        end

        def validate_tailoring_rule(rule)
          return if IGNORED_TAGS.include?(rule.name)

          raise ImportError, "Rule '#{rule.name}' is not supported." unless SUPPORTED_RULES.include?(rule.name)
        end

        def get_collation_elements(collator, string)
          iter = collator.get_collation_element_iterator(string)

          collation_elements = []
          ce = iter.next

          while ce != Java::ComIbmIcuText::CollationElementIterator::NULLORDER
            p1 = (ce >> 24) & LAST_BYTE_MASK
            p2 = (ce >> 16) & LAST_BYTE_MASK

            primary   = p2.zero? ? p1 : (p1 << 8) + p2
            secondary = (ce >> 8) & LAST_BYTE_MASK
            tertiarly = ce & LAST_BYTE_MASK

            collation_elements << [primary, secondary, tertiarly]

            ce = iter.next
          end

          collation_elements
        end

        def get_code_points(string)
          TwitterCldr::Normalization::NFD.normalize_code_points(TwitterCldr::Utils::CodePoints.from_string(string))
        end

      end

    end
  end
end