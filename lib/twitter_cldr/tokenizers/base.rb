# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class Base
      attr_reader :resource, :locale
      attr_reader :token_splitter_regex, :token_type_regexes, :paths
      attr_accessor :type, :placeholders

      def initialize(options = {})
        @locale = TwitterCldr.convert_locale(options[:locale] || TwitterCldr::DEFAULT_LOCALE)
        self.init_resources
        self.init_placeholders
      end

      protected

      # Not to be confused with tokenize_pattern, which pulls out placeholders.  Tokenize_format actually splits a completely
      # expanded format string into whatever parts are defined by the subclass's token type and token splitter regexes.
      def tokenize_format(text)
        final = []
        text.split(self.token_splitter_regex).each_with_index do |token, index|
          unless index == 0 && token == ""
            self.token_type_regexes.each do |token_type|
              if token =~ token_type[:regex]
                if token_type[:type] == :composite
                  content = token.match(token_type[:content])[1]
                  final << CompositeToken.new(tokenize_format(content))
                else
                  final << Token.new(:value => token, :type => token_type[:type])
                end

                break
              end
            end
          end
        end
        final
      end

      def tokens_for(path, type)
        @@token_cache ||= {}
        cache_key = TwitterCldr::Utils.compute_cache_key(@locale, path.join('.'), type)

        unless @@token_cache.include?(cache_key)
          result = []
          tokens = expand_pattern(pattern_for(traverse(path)), type)

          tokens.each do |token|
            if token.is_a?(Token) || token.is_a?(CompositeToken)
              result << token
            else
              result += tokenize_format(token[:value])
            end
          end

          @@token_cache[cache_key] = result
        end

        @@token_cache[cache_key]
      end

      def tokens_with_placeholders_for(key)
        @@token_cache ||= {}
        cache_key = self.compute_cache_key(@locale, key, type)

        unless @@token_cache.include?(cache_key)
          result = []
          tokens = self.tokenize_pattern(self.pattern_for(self.traverse(key)))
          tokens.each do |token|
            result << token
          end
          @@token_cache[cache_key] = result
        end
        @@token_cache[cache_key]
      end

      def compute_cache_key(*pieces)
        if pieces && pieces.size > 0
          pieces.join("|").hash
        else
          0
        end
      end

      def init_placeholders
        @placeholders = {}
      end

      def traverse(path, haystack = @resource)
        path.inject(haystack) do |current, segment|
          if current.is_a?(Hash) && current.has_key?(segment)
            current[segment]
          else
            return
          end
        end
      end

      # expands all path symbols
      def expand(current, haystack)
        if current.is_a?(Symbol)
          expand(traverse(current.to_s.split('.').map(&:to_sym), haystack), haystack)
        elsif current.is_a?(Hash)
          current.inject({}) do |ret, key_val|
            key, val = key_val
            ret[key] = expand(val, haystack)
            ret
          end
        else
          current
        end
      end

      def expand_pattern(format_str, type)
        if format_str.is_a?(Symbol)
          # symbols mean another path was given
          self.expand_pattern(self.pattern_for(self.traverse(format_str.to_s.split('.').map(&:to_sym))), type)
        else
          parts = tokenize_pattern(format_str)
          final = []

          parts.each do |part|
            case part[:type]
              when :placeholder then
                placeholder = self.choose_placeholder(part[:value], @placeholders)
                final += placeholder ? placeholder.tokens(:type => type) : []
              else
                final << part
            end
          end

          final
        end
      end

      # Tokenize_pattern is supposed to take a pattern found in the YAML resource files and break it into placeholders and plaintext.
      # Placeholders are delimited by single and double curly braces, plaintext is everything else.
      def tokenize_pattern(pattern_str)
        results = []
        pattern_str.split(/(\{\{?\w*\}?\}|\'\w+\')/).each do |piece|
          unless piece.empty?
            case piece[0].chr
              when "{"
                results << { :value => piece, :type => :placeholder }
              else
                results << { :value => piece, :type => :plaintext }
            end
          end
        end
        results
      end

      def choose_placeholder(token, placeholders)
        if token[0..1] == "{{"
          token_value = token[2..-3]
          found = placeholders.find { |placeholder| placeholder[:name].to_s == token_value }
        else
          found = placeholders[token[1..-2].to_i]
        end

        found ? found[:object] : nil
      end
    end
  end
end
