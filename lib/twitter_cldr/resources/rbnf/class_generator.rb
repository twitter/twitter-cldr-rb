# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'ruby2ruby'

require 'pry-nav'

module TwitterCldr
  module Resources
    module Rbnf
      class ClassGenerator

        DEFAULT_RADIX = 10

        attr_reader :output_path

        # Arguments:
        #
        #   output_path - output directory for imported YAML files
        #
        def initialize(output_path)
          @output_path = output_path
          @code_generator = Ruby2Ruby.new
        end

        def generate(locales)
          locales.each.with_index do |locale, idx|
            generate_locale(locale)
            yield idx, locales.size, locale.to_s if block_given?
          end
        end

        private

        attr_reader :code_generator

        def generate_locale(locale)
          locale = TwitterCldr.convert_locale(locale)
          class_name = RuleSet.get_safe_class_name(locale)
          resource = resource_for(locale)[locale]
          grouping_asts = [RuleSet.create_module_memo_ast(locale, class_name)]
          grouping_asts += generate_classes_for(resource, class_name)
          file_name = File.join(output_path, "#{locale.to_s}.rb")

          module_hierarchy = [
            "TwitterCldr",
            "Formatters",
            "RuleBasedNumberFormatter"
          ]

          module_ast = RuleSet.create_module_ast(
            grouping_asts,
            module_hierarchy
          )

          File.open(file_name, "w+") do |f|
            f.write("# encoding: UTF-8\n\n")
            f.write("# Copyright 2012 Twitter, Inc\n")
            f.write("# http://www.apache.org/licenses/LICENSE-2.0\n\n")
            f.write(code_generator.process(module_ast))
          end
        end

        def generate_classes_for(resource, class_name)
          extract_rbnf_functions_from(resource).map do |grouping|
            function_asts = grouping.rule_sets.flat_map do |name, rule_set|
              rule_set.to_function_ast
            end

            RuleSet.create_class_ast(
              class_name,
              RuleSet.get_safe_grouping_name(grouping.name).to_sym,
              function_asts
            )
          end
        end

        def extract_rbnf_functions_from(data)
          data[:rbnf][:grouping].map do |grouping|
            group = Grouping.new(grouping[:type], {})
            grouping[:ruleset].inject(group.rule_sets) do |ruleset_ret, ruleset|
              type = RuleSet.get_safe_renderer_name(ruleset[:type])
              access = ruleset[:access]
              ruleset_ret[type] = RuleSet.new(type, access).tap do |set|
                ruleset[:rules].each do |rule|
                  set.add_rule(
                    Rule.new(
                      rule[:value].to_s,
                      rule[:rule]
                        .gsub(/\A'/, '')
                        .gsub("←", '<')
                        .gsub("→", '>'),
                      rule[:radix] || DEFAULT_RADIX,
                    )
                  )
                end
              end
              ruleset_ret
            end
            group
          end
        end

        def resource_for(locale)
          TwitterCldr.resources.get_locale_resource(locale, "rbnf")
        end

      end
    end
  end
end