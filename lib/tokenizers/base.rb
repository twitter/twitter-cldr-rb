module TwitterCldr
  module Tokenizers
    class Base
      attr_reader :resource, :locale
      attr_accessor :type

      def initialize(options = {})
        @locale = options[:locale] || TwitterCldr::DEFAULT_LOCALE
        @type = options[:type] || :default
        self.init_resources
        self.init_placeholders
      end

      protected

      def tokens_for(key)
        final = []
        tokens = self.expand_pattern(self.pattern_for(self.traverse(key)))

        tokens.each do |token|
          if token.is_a?(Token)
            final << token
          else
            final += tokenize_format(token[:value])
          end
        end

        final
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
          parts = tokenize_pattern(format_str)
          final = []

          parts.each do |part|
            case part[:type]
              when :placeholder then
                placeholder = @placeholders[part[:value].to_sym]
                final += placeholder ? placeholder.tokens : []
              else
                final << part
            end
          end

          final
        end
      end

      def tokenize_pattern(pattern_str)
        results = []
        pattern_str.split(/(\{\{\w*\}\}|\'\w+\')/).each do |piece|
          unless piece.empty?
            case piece[0].chr
              when "{"
                results << { :value => piece[2..-3], :type => :placeholder }
              else
                results << { :value => piece, :type => :plaintext }
            end
          end
        end
        results
      end
    end
  end
end