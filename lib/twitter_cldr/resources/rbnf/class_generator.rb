# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'ruby2ruby'

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
          resource = resource_for(locale)[locale]

          function_asts = extract_rbnf_functions_from(resource).inject([]) do |ret, (name, rule_set)|
            ret += rule_set.to_function_ast
            ret
          end

          class_name = TwitterCldr::Shared::Languages.from_code(locale).gsub(" ", "")
          file_name = File.join(output_path, "#{locale.to_s}.rb")
          module_hierarchy = %w[TwitterCldr Formatters RuleBasedNumberFormatter]

          class_ast = RuleSet.create_class_ast(
            locale,
            class_name,
            function_asts,
            module_hierarchy
          )

          File.open(file_name, "w+") do |f|
            f.write("# encoding: UTF-8\n\n")
            f.write("# Copyright 2012 Twitter, Inc\n")
            f.write("# http://www.apache.org/licenses/LICENSE-2.0\n\n")
            f.write(code_generator.process(class_ast))
          end
        end

        def extract_rbnf_functions_from(data)
          data[:rbnf][:grouping].inject({}) do |grouping_ret, grouping|
            grouping[:ruleset].inject(grouping_ret) do |ruleset_ret, ruleset|
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
            grouping_ret
          end
        end

        def resource_for(locale)
          TwitterCldr.resources.get_locale_resource(locale, "rbnf")
        end

      end
    end
  end
end