# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Timezones
    class GmtTimezone < Timezone
      def to_s
        gmt_format.sub('{0}', hour)
      end

      private

      def hour
        type = offset.positive? ? :positive : :negative
        time = Time.new(1970, 1, 1, offset_hour, offset_minute)
        formatted_hour = hour_formatter.format(hour_tokens(type), time)
        numbering_system.transliterate(formatted_hour)
      end

      def numbering_system
        @numbering_system ||= TwitterCldr::Shared::NumberingSystem.for_locale(locale)
      end

      def hour_formatter
        @hour_formatter = TwitterCldr::Formatters::DateTimeFormatter.new(nil)
      end

      def hour_tokens(type)
        (@hour_tokens ||= {})[type] ||= hour_tokenizer.tokenize(hour_format(type))
      end

      def hour_tokenizer
        @hour_tokenizer ||= TwitterCldr::Tokenizers::TimeTokenizer.new(nil)
      end

      def gmt_format
        resource[locale][:formats][:gmt_format]
      end

      def hour_format(type)
        case type
          when :positive
            hour_formats.first
          else
            hour_formats.last
        end
      end

      def hour_formats
        @hour_formats ||= resource[:formats][:hour_format].split(';')
      end
    end
  end
end
