# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    class RuleSetBuilder

      class << self
        def load(locale, boundary_type, options = {})
          rules = compile_rules_for(boundary_type)
          RuleSet.new(locale, rules, boundary_type, options)
        end

        # See the comment above exceptions_for. Basically, we only support exceptions
        # for the "sentence" boundary type since the ULI JSON data doesn't distinguish
        # between boundary types.
        def exception_rule_for(locale, boundary_type)
          cache_key = TwitterCldr::Utils.compute_cache_key(locale, boundary_type)
          exceptions_cache[cache_key] ||= begin
            exceptions = exceptions_for(locale, boundary_type)
            regex_contents = exceptions.map { |exc| Regexp.escape(exc) }.join("|")
            parse("(?:#{regex_contents}) ×", nil).tap do |rule|
              rule.id = 0
            end
          end
        end

        # The implicit final rule is always "Any ÷ Any"
        def implicit_final_rule
          @implicit_final_rule ||=
            parse('. ÷ .', nil).tap do |rule|
              rule.id = 9999
            end
        end

        # The implicit initial rules are always "start-of-text ÷"
        # and "÷ end-of-text". We don't need the start-of-text one.
        def implicit_end_of_text_rule
          @implicit_end_of_text_rule ||=
            parse('.\z ÷', nil).tap do |rule|
              rule.id = 9998
            end
        end

        private

        # The boundary_type param is not currently used since the ULI JSON resource that
        # exceptions are generated from does not distinguish between boundary types. The
        # XML version does, however, so the JSON will hopefully catch up at some point and
        # we can make use of this second parameter. For the time being, compile_exception_rule_for
        # (which calls this function) assumes a "sentence" boundary type.
        def exceptions_for(locale, boundary_type)
          exceptions_resource_cache[locale] ||= begin
            TwitterCldr.get_resource('uli', 'segments', locale)[locale][:exceptions]
          rescue Resources::ResourceLoadError
            []
          end
        end

        def boundary_name_for(str)
          str.gsub(/(?:^|\_)([A-Za-z])/) { |s| $1.upcase } + 'Break'
        end

        # tokenizes and parses rules from segment_root
        def compile_rules_for(boundary_type)
          rule_cache[boundary_type] ||= begin
            boundary_name = boundary_name_for(boundary_type)
            boundary_data = resource_for(boundary_name)
            symbol_table = symbol_table_for(boundary_data)
            rules_for(boundary_data, symbol_table)
          end
        end

        def symbol_table_for(boundary_data)
          table = TwitterCldr::Parsers::SymbolTable.new
          boundary_data[:variables].each do |variable|
            id = variable[:id].to_s
            tokens = segmentation_parser.tokenize_regex(variable[:value])
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
            r = parse(rule[:value], symbol_table)
            r.string = rule[:value]
            r.id = rule[:id]
            r
          end
        end

        def parse(text, symbol_table)
          segmentation_parser.parse(
            text, { symbol_table: symbol_table }
          )
        end

        def resource_for(boundary_name)
          root_resource[:segments][boundary_name.to_sym]
        end

        def segmentation_parser
          @segmentation_parser ||= Segmentation::Parser.new
        end

        def root_resource
          @root_resource ||= TwitterCldr.get_resource(
            'shared', 'segments', 'segments_root'
          )
        end

        def rule_cache
          @rule_cache ||= {}
        end

        def exceptions_resource_cache
          @exceptions_resource_cache ||= {}
        end

        def exceptions_cache
          @exceptions_cache ||= {}
        end
      end

    end
  end
end
