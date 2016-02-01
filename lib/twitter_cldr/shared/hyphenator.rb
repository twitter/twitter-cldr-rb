# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    class Hyphenator
      DEFAULT_LEFT_HYPHEN_MIN = 2
      DEFAULT_RIGHT_HYPHEN_MIN = 2

      class << self
        def get(locale)
          cache[locale] ||= begin
            resource = resource_for(locale)
            new(resource[:rules], resource[:options])
          end
        end

        private

        def cache
          @cache ||= {}
        end

        def resource_for(locale)
          TwitterCldr.get_resource('shared', 'hyphenation', locale)
        end
      end

      attr_reader :rules, :options, :trie

      def initialize(rules, options)
        @rules = rules
        @options = options
        @trie = build_trie_from(rules)
      end

      # 0x00AD is a soft hyphen
      def hyphenate(text, hyphen = "\u00AD")
        each_chunk(text).to_a.join(hyphen)
      end

      def each_chunk(text)
        if block_given?
          last_pos = 0

          each_position(text) do |pos|
            yield text[last_pos...pos].tap { last_pos = pos }
          end

          if last_pos < text.size - 1
            yield text[last_pos..text.size]
          end
        else
          to_enum(__method__, text)
        end
      end

      def each_position(text)
        if block_given?
          break_weights = Array.new(text.size - 1, 0)

          text.each_char.with_index do |char, idx|
            subtrie = trie.root
            counter = idx

            while subtrie
              subtrie = subtrie.child(text[counter])
              counter += 1

              if subtrie && subtrie.has_value?
                update_break_weights(subtrie.value, break_weights, idx)
              end
            end

            if idx > 0 && in_bounds?(idx, text.size)
              yield idx if break_weights[idx] % 2 == 0
            end
          end
        else
          to_enum(__method__, text)
        end
      end

      private

      def in_bounds?(idx, length)
        left_in_bounds?(idx) && right_in_bounds?(idx, length)
      end

      def left_in_bounds?(idx)
        (idx + 1) >= left_hyphen_min
      end

      def right_in_bounds?(idx, length)
        (length - (idx + 1)) > right_hyphen_min
      end

      def update_break_weights(pattern, break_weights, start_idx)
        pattern_idx = 0

        pattern.each_char do |segment|
          if segment =~ /\d/
            int_seg = segment.to_i
            idx = (start_idx + pattern_idx) - 1

            break_weights[idx] = if break_weights[idx] > int_seg
              break_weights[idx]
            else
              int_seg
            end
          else
            pattern_idx += 1
          end
        end
      end

      def left_hyphen_min
        options.fetch(:lefthyphenmin, DEFAULT_LEFT_HYPHEN_MIN)
      end

      def right_hyphen_min
        options.fetch(:righthyphenmin, DEFAULT_RIGHT_HYPHEN_MIN)
      end

      def build_trie_from(rules)
        TwitterCldr::Utils::Trie.new.tap do |trie|
          rules.each do |rule|
            trie.add(rule.gsub(/\d/, '').each_char, rule)
          end
        end
      end
    end
  end
end
