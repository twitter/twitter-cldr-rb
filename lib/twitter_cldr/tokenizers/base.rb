# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class Base
      attr_reader :resource, :locale
      attr_reader :token_splitter_regexes, :token_type_regexes, :paths
      attr_accessor :type, :format, :placeholders

      def initialize(options = {})
        @locale = TwitterCldr.convert_locale(options[:locale] || TwitterCldr::DEFAULT_LOCALE)
        init_resources
        init_placeholders
      end

      protected

      # Not to be confused with tokenize_pattern, which pulls out placeholders.  Tokenize_format actually splits a completely
      # expanded format string into whatever parts are defined by the subclass's token type and token splitter regexes.
      def tokenize_format(text)
        text.split(token_splitter_regex_for(type)).each_with_index.inject([]) do |ret, (token, index)|
          unless index == 0 && token == ""
            regexes = token_type_regexes_for(type)

            token_type = regexes.inject([]) do |match_ret, (token_type, matchers)|
              match_ret << token_type if token =~ matchers[:regex]
              match_ret
            end.min { |a, b| regexes[a][:priority] <=> regexes[b][:priority] }

            if token_type == :composite
              content = token.match(regexes[token_type][:content])[1]
              ret << CompositeToken.new(tokenize_format(content))
            else
              ret << Token.new(:value => token, :type => token_type)
            end
          end
          ret
        end
      end

      def token_type_regexes_for(type)
        token_type_regexes[type] || token_type_regexes[:else]
      end

      def token_splitter_regex_for(type)
        token_splitter_regexes[type] || token_splitter_regexes[:else]
      end

      def tokens_for(path, additional_cache_key_params = [])
        tokens_for_pattern(pattern_for(traverse(path)), path, additional_cache_key_params)
      end

      def tokens_for_pattern(pattern, path, additional_cache_key_params = [])
        cache_key = TwitterCldr::Utils.compute_cache_key(@locale, path.join('.'), type, format || "nil", *additional_cache_key_params)

        unless token_cache.include?(cache_key)
          result = []
          tokens = expand_pattern(pattern)

          tokens.each do |token|
            if token.is_a?(Token) || token.is_a?(CompositeToken)
              result << token
            else
              result += tokenize_format(token[:value])
            end
          end

          token_cache[cache_key] = result
        end

        token_cache[cache_key]
      end

      def tokens_with_placeholders_for(key)
        cache_key = TwitterCldr::Utils.compute_cache_key(@locale, key, type)

        unless token_cache.include?(cache_key)
          result = []
          tokens = tokenize_pattern(pattern_for(traverse(key)))
          tokens.each do |token|
            result << token
          end
          token_cache[cache_key] = result
        end

        token_cache[cache_key]
      end

      def token_cache
        @@token_cache ||= {}
      end

      def init_placeholders
        @placeholders = {}
      end

      def traverse(path, hash = @resource)
        TwitterCldr::Utils.traverse_hash(hash, path)
      end

      # expands all path symbols
      def expand(current, haystack)
        if current.is_a?(Symbol)
          expand(traverse(current.to_s.split('.').map(&:to_sym), haystack), haystack)
        elsif current.is_a?(Hash)
          current.inject({}) do |ret, (key, val)|
            ret[key] = expand(val, haystack)
            ret
          end
        else
          current
        end
      end

      def expand_pattern(format_str)
        if format_str.is_a?(Symbol)
          # symbols mean another path was given
          expand_pattern(pattern_for(traverse(format_str.to_s.split('.').map(&:to_sym))))
        else
          parts = tokenize_pattern(format_str)
          final = []

          parts.each do |part|
            case part[:type]
              when :placeholder
                placeholder = choose_placeholder(part[:value], @placeholders)
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
