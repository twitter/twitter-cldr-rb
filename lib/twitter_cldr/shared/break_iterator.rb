# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    class BreakIterator

      attr_reader :locale, :use_uli_exceptions

      def initialize(locale = TwitterCldr.locale, options = {})
        @use_uli_exceptions = !!options.fetch(:use_uli_exceptions, true)
        @locale = locale
      end

      def each_sentence(str, &block)
        each_boundary(str, "sentence", &block)
      end

      def each_word(str, &block)
        raise NotImplementedError.new("Word segmentation is not currently supported.")
      end

      def each_line(str, &block)
        raise NotImplementedError.new("Line segmentation is not currently supported.")
      end

      private

      def boundary_name_for(str)
        str.gsub(/(?:^|\_)([A-Za-z])/) { |s| $1.upcase } + "Break"
      end

      def each_boundary(str, boundary_type)
        if block_given?
          rules = compile_rules_for(locale, boundary_type)
          match = nil
          last_offset = 0
          current_position = 0
          search_str = str.dup

          until search_str.size == 0
            rule = rules.find { |rule| match = rule.match(search_str) }

            if rule.boundary_symbol == :break
              break_offset = current_position + match.boundary_offset
              yield str[last_offset...break_offset]
              last_offset = break_offset
            end

            search_str = search_str[match.boundary_offset..-1]
            current_position += match.boundary_offset
          end

          if last_offset < (str.size - 1)
            yield str[last_offset..-1]
          end
        else
          to_enum(__method__, str, boundary_type)
        end
      end

      # See the comment above exceptions_for. Basically, we only support exceptions
      # for the "sentence" boundary type since the ULI JSON data doesn't distinguish
      # between boundary types.
      def compile_exception_rule_for(locale, boundary_type, boundary_name)
        if boundary_type == "sentence"
          cache_key = TwitterCldr::Utils.compute_cache_key(locale, boundary_type)
          self.class.exceptions_cache[cache_key] ||= begin
            exceptions = exceptions_for(locale, boundary_name)
            regex_contents = exceptions.map { |exc| Regexp.escape(exc) }.join("|")
            segmentation_parser.parse(
              segmentation_tokenizer.tokenize("(?:#{regex_contents}) ×")
            )
          end
        end
      end

      def self.exceptions_cache
        @exceptions_cache ||= {}
      end

      # Grabs rules from segment_root, applies custom tailorings (our own, NOT from CLDR),
      # and optionally integrates ULI exceptions.
      def compile_rules_for(locale, boundary_type)
        rules = self.class.rule_cache[boundary_type] ||= begin
          boundary_name = boundary_name_for(boundary_type)
          boundary_data = resource_for(boundary_name)
          symbol_table = symbol_table_for(boundary_data)
          root_rules = rules_for(boundary_data, symbol_table)

          tailoring_boundary_data = tailoring_resource_for(locale, boundary_name)
          tailoring_rules = rules_for(tailoring_boundary_data, symbol_table)
          merge_rules(root_rules, tailoring_rules)
        end

        if use_uli_exceptions
          exception_rule = compile_exception_rule_for(locale, boundary_type, boundary_name)
          rules = rules.dup  # avoid modifying the cached rules
          rules.insert(0, exception_rule)
        end

        rules
      end

      # replaces ruleset1's rules with rules with the same id from ruleset2
      def merge_rules(ruleset1, ruleset2)
        result = ruleset1.dup
        ruleset2.each do |new_rule|
          if existing_idx = result.find_index { |rule| rule.id == new_rule.id }
            result[existing_idx] = new_rule
          end
        end
        result
      end

      def self.rule_cache
        @rule_cache ||= {}
      end

      def symbol_table_for(boundary_data)
        table = TwitterCldr::Parsers::SymbolTable.new
        boundary_data[:variables].each do |variable|
          id = variable[:id].to_s
          tokens = segmentation_tokenizer.tokenize(variable[:value])
          # note: variables can be redefined (add replaces if key already exists)
          table.add(id, resolve_symbols(tokens, table))
        end
        table
      end

      def resolve_symbols(tokens, symbol_table)
        tokens.inject([]) do |ret, token|
          if token.type == :variable
            ret += symbol_table.fetch(token.value)
          else
            ret << token
          end
          ret
        end
      end

      def rules_for(boundary_data, symbol_table)
        boundary_data[:rules].map do |rule|
          r = segmentation_parser.parse(
            segmentation_tokenizer.tokenize(rule[:value]), {
              :symbol_table => symbol_table
            }
          )

          r.string = rule[:value]
          r.id = rule[:id]
          r
        end
      end

      def self.segmentation_tokenizer
        @segmentation_tokenizer ||= TwitterCldr::Tokenizers::SegmentationTokenizer.new
      end

      def segmentation_tokenizer
        self.class.segmentation_tokenizer
      end

      def self.segmentation_parser
        @segmentation_parser ||= TwitterCldr::Parsers::SegmentationParser.new
      end

      def segmentation_parser
        self.class.segmentation_parser
      end

      def resource_for(boundary_name)
        self.class.root_resource[:segments][boundary_name.to_sym]
      end

      def tailoring_resource_for(locale, boundary_name)
        cache_key = TwitterCldr::Utils.compute_cache_key(locale, boundary_name)
        self.class.tailoring_resource_cache[cache_key] ||= begin
          res = TwitterCldr.get_resource("shared", "segments", "tailorings", locale)
          res[locale][:segments][boundary_name.to_sym]
        end
      end

      def self.tailoring_resource_cache
        @tailoring_resource_cache ||= {}
      end

      def self.root_resource
        @root_resource ||= TwitterCldr.get_resource("shared", "segments", "segments_root")
      end

      # The boundary_name param is not currently used since the ULI JSON resource that
      # exceptions are generated from does not distinguish between boundary types. The
      # XML version does, however, so the JSON will hopefully catch up at some point and
      # we can make use of this second parameter. For the time being, compile_exception_rule_for
      # (which calls this function) assumes a "sentence" boundary type.
      def exceptions_for(locale, boundary_name)
        self.class.exceptions_resource_cache[locale] ||= begin
          TwitterCldr.get_resource("uli", "segments", locale)[locale][:exceptions]
        rescue ArgumentError
          []
        end
      end

      def self.exceptions_resource_cache
        @exceptions_resource_cache ||= {}
      end

    end
  end
end
