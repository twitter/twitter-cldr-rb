# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    class InvalidTransformRuleError < StandardError; end

    class Transformer
      CHAIN = [
        :normal_fallback1, :normal_fallback2, :laddered_fallback1,
        :normal_fallback3, :laddered_fallback2
      ]

      RULE_CLASSES = [
        CommentRule,
        VariableRule,
        Transforms::TransformRule,
        Filters::FilterRule,
        Conversions::ConversionRule,
      ]

      class << self
        def for_locales(source_locale, target_locale)
          source_chain = map_chain_for(source_locale)
          target_chain = map_chain_for(target_locale)
          variants = variants_for(source_locale, target_locale)

          find_in_chains(
            source_chain, target_chain, variants
          )
        end

        def exists?(transform_id_str)
          id = TransformId.parse(transform_id_str)
          resource_exists?(id) || resource_exists?(id.reverse)
        rescue
          false
        end

        def get(transform_id_str)
          id = TransformId.parse(transform_id_str)

          if resource_exists?(id)
            load(id).forward_rule_set
          else
            reversed_id = id.reverse

            if resource_exists?(reversed_id)
              transformer = load(reversed_id)

              if transformer.bidirectional?
                transformer.backward_rule_set
              end
            end
          end
        end

        def each_transform
          if block_given?
            path = TwitterCldr.resources.absolute_resource_path(
              File.join('shared', 'transforms')
            )

            Dir.glob(File.join(path, '*.*')).each do |file|
              file = File.basename(file.chomp(File.extname(file)))
              source, target, variant = TransformId.split(file)
              yield TransformId.join(source, target, variant)
            end
          else
            to_enum(__method__)
          end
        end

        private

        def load(transform_id)
          transformers[transform_id.to_s] ||= begin
            resource = resource_for(transform_id)
            direction = direction_from(resource)
            new(parse_resource(resource), direction, transform_id)
          end
        end

        def build(rule_list, direction)
          rules = parse_rules(rule_list)
          new(rules, direction)
        end

        def direction_from(resource)
          case transform_from(resource)[:direction]
            when 'both'
              :bidirectional
            else
              :forward
          end
        end

        def transformers
          @transformers ||= {}
        end

        def parse_resource(resource)
          parse_rules(rules_from(resource))
        end

        def parse_rules(rule_list)
          symbol_table = {}
          rules = []

          parse_each_rule(rule_list, symbol_table) do |rule|
            if rule.is_variable?
              symbol_table[rule.name] = rule
            elsif !rule.is_comment?
              rules << rule
            end
          end

          rules
        end

        def parse_each_rule(rule_list, symbol_table)
          rule_list.each_with_index do |rule_text, idx|
            if klass = identify_class(rule_text)
              rule = klass.parse(
                rule_text, symbol_table, idx
              )

              yield rule
            else
              raise InvalidTransformRuleError,
                "Invalid rule: '#{rule_text}'"
            end
          end
        end

        def identify_class(rule_text)
          RULE_CLASSES.find do |klass|
            klass.accepts?(rule_text)
          end
        end

        def rules_from(resource)
          transform_from(resource)[:rules]
        end

        def transform_from(resource)
          resource[:transforms].first
        end

        def resource_for(transform_id)
          TwitterCldr.get_resource(
            'shared', 'transforms', transform_id.file_name
          )
        end

        def resource_exists?(transform_id)
          TwitterCldr.resource_exists?(
            'shared', 'transforms', transform_id.file_name
          )
        end

        def find_in_chains(source_chain, target_chain, variants)
          variants.each do |variant|
            target_chain.each do |target|
              source_chain.each do |source|
                source_str = join_subtags(source, variant)
                target_str = join_subtags(target, variant)
                transform_id_str = TransformId.join(source_str, target_str)

                if rule_set = get(transform_id_str)
                  return rule_set
                end
              end
            end
          end
        end

        def join_subtags(tags, variant)
          tags.join('_').tap do |result|
            result << "_#{variant}" if variant
          end
        end

        def variants_for(source_locale, target_locale)
          (source_locale.variants + target_locale.variants + [nil]).uniq
        end

        def map_chain_for(locale)
          CHAIN.map { |link| send(link, locale) }
        end

        def normal_fallback1(locale)
          [locale.language, locale.script, locale.region]
        end

        def normal_fallback2(locale)
          [locale.language, locale.script]
        end

        def normal_fallback3(locale)
          [locale.language]
        end

        def laddered_fallback1(locale)
          [locale.language, locale.region]
        end

        def laddered_fallback2(locale)
          [locale.script]
        end
      end

      attr_reader :rules, :direction, :transform_id

      def initialize(rules, direction, transform_id)
        @rules = rules
        @direction = direction
        @transform_id = transform_id
      end

      # all rules are either forward or bidirectional
      def bidirectional?
        direction == :bidirectional
      end

      alias_method :can_invert?, :bidirectional?

      def forward_rule_set
        @forward_rule_set ||= begin
          RuleSet.new(
            filter_rule, inverse_filter_rule,
            ct_rules, transform_id
          )
        end
      end

      def backward_rule_set
        if can_invert?
          @backward_rule_set ||= forward_rule_set.invert
        else
          raise NotInvertibleError,
            "cannot invert this #{self.class.name}"
        end
      end

      private

      def ct_rules
        @ct_rules ||= rules.select do |rule|
          rule.is_transform_rule? || rule.is_conversion_rule?
        end
      end

      def filter_rule
        @filter_rule ||= if is_forward_filter?(rules.first)
          rules.first
        else
          Filters::NullFilter.new
        end
      end

      def inverse_filter_rule
        @inverse_filter_rule ||= if is_backward_filter?(rules.last)
          rules.last
        else
          Filters::NullFilter.new
        end
      end

      def is_forward_filter?(rule)
        rule.is_filter_rule? && !rule.backward?
      end

      def is_backward_filter?(rule)
        rule.is_filter_rule? && rule.backward?
      end
    end

  end
end
