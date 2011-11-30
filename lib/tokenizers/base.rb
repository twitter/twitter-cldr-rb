module TwitterCldr
  module Tokenizers
    class Base
      attr_accessor :base_obj
      attr_reader :resource, :locale

      def initialize(options = {})
        @locale = options[:locale] || TwitterCldr::DEFAULT_LOCALE
        @type = options[:type] || :default
        self.init_resources
        self.init_placeholders
      end

      #protected

      def tokens_for(key)
        self.expand_pattern(self.pattern_for(self.traverse(key)))
      end

      def init_placeholders
        @placeholders = {}
      end

      def traverse(needle, haystack = @resource)
        segments = needle.to_s.split(".")
        final = haystack
        segments.each { |segment| final = final[segment.to_sym] }
        final
      end

      def expand_pattern(format_str)
        if format_str.is_a?(Symbol)
          # symbols mean another path was given
          self.expand_pattern(self.pattern_for(self.traverse(format_str)))
        else
          parts = tokenize_format(format_str)
          final = []

          parts.each do |part|
            case part[:type]
              when :placeholder then
                placeholder = @placeholders[part[:value].to_sym]
                tokens = placeholder ? placeholder.tokens : []
              else
                tokens = [part]
            end

            # adjust start indexes
            tokens.each do |token|
              token[:start] = final.last ? final.last[:start] + final.last[:length] + 1 : 0
              final << token
            end
          end

          final
        end
      end

      def tokenize_format(format_str)
        results = []
        placeholders = split_format_str(format_str)

        placeholders.each_with_index do |placeholder, index|
          start = index == 0 ? 0 : (results.last[:start] + results.last[:length])
          finish = placeholder[:start]
          results << { :start => start, :length => (finish - start), :value => format_str[start...finish], :type => :pattern } if (finish - start) > 0
          results << placeholder
        end

        start = results.size == 0 ? 0 : (results.last[:start] + results.last[:length])
        finish = format_str.size
        results << { :start => start, :length => (finish - start), :value => format_str[start...finish], :type => :pattern } if (finish - start) > 0

        results
      end

      def split_format_str(format_str)
        results = []
        format_str.scan(/(\{\{\w*\}\}|\'\w+\')/) do |result|
          puts Regexp.last_match.offset(0).inspect
          case result.first[0].chr
            when "{"
              results << { :start => Regexp.last_match.offset(0).first, :length => result.first.size, :value => result.first[2..-3], :type => :placeholder }
            when "'"
              results << { :start => Regexp.last_match.offset(0).first, :length => result.first.size, :value => result.first[1..-2], :type => :plaintext }
          end
        end
        results
      end
    end
  end
end