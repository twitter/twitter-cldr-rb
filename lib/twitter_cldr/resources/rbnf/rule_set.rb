# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'sexp'

module TwitterCldr
  module Resources
    module Rbnf

      Grouping = Struct.new(:name, :rule_sets)

      class RuleSet

        attr_reader :type, :access, :rules

        def initialize(type, access)
          @type = type
          @access = access
        end

        class << self

          def get_display_name(name)
            name
              .gsub(/[^\w-]/, '-')
              .gsub(/[-_]+/, '_')
              .gsub('GREEKNUMERALMAJUSCULES', 'GreekNumeralMajuscules')
          end

          def get_safe_renderer_name(renderer_name)
            get_display_name("format-#{renderer_name}")
          end

          def get_safe_grouping_name(grouping_name)
            grouping_name.gsub(/Rules\z/, "")
          end

          def get_safe_class_name(locale)
            TwitterCldr::Shared::Languages.from_code(locale).gsub(" ", "").to_sym
          end

          def create_class_ast(namespace, class_name, function_asts)
            s(:class, s(:colon2, s(:const, namespace), class_name), nil, s(:sclass, s(:self), *function_asts))
          end

          def create_module_memo_ast(locale, class_name)
            s(:attrasgn,
              s(:ivar, :@formatters),
              :[]=,
              s(:lit, locale),
              s(:cdecl,
                class_name,
                s(:iter,
                  s(:call, s(:const, :Module), :new),
                  s(:args)
                )
              )
            )
          end

          def create_module_ast(sexps, module_hierarchy = [])
            if module_hierarchy.size < 1
              raise "Must have a module hierarchy of at least depth 1."
            end

            mod = s(:module, module_hierarchy.last, *sexps)

            (0...module_hierarchy.size - 1).reverse_each do |i|
              mod = s(:module, module_hierarchy[i], mod)
            end

            mod
          end

        end

        def add_rule(rule)
          rules[rule.value] = rule
        end

        def to_function_ast
          statement_asts = []

          if rule_for('x.0') || rule_for('x.x')
            # "is_fractional = n != n.floor"
            statement_asts << s(:lasgn, :is_fractional,
              s(:call,
                s(:call, nil, :n), :!=, s(:call, s(:call, nil, :n), :floor)
              )
            )
          end

          if rule = rule_for('x.0')
            statement_asts << condition_to_statement_ast(
              # is_fractional
              s(:call, nil, :is_fractional),
              rule
            )
          end

          if rule = rule_for('-x')
            statement_asts << condition_to_statement_ast(
              # n < 0
              s(:call, s(:call, nil, :n), :<, s(:lit, 0)),
              rule
            )
          end

          if rule = rule_for('x.x')
            statement_asts << condition_to_statement_ast(
              # is_fractional && n > 1
              s(:and,
                s(:call, nil, :is_fractional),
                s(:call, s(:call, nil, :n), :>, s(:lit, 1))
              ),
              rule
            )
          end

          if rule = rule_for('0.x')
            statement_asts << condition_to_statement_ast(
              # "n > 0 && n < 1"
              s(:and,
                s(:call, s(:call, nil, :n), :>, s(:lit, 0)),
                s(:call, s(:call, nil, :n), :<, s(:lit, 1))
              ),
              rule
            )
          end

          num_vals = rules.keys
            .select { |key| key =~ /\A\d+\z/ }
            .map { |key| key.to_i(10) }
            .sort { |a, b| b - a }

          statement_asts += num_vals.map do |num_val|
            condition_to_statement_ast(
              # "n >= #{num_val}"
              s(:call, s(:call, nil, :n), :>=, s(:lit, num_val)),
              rule_for(num_val)
            )
          end

          # "def self.#{type}(n); #{statement_asts.join("; ")}; end;"
          final = [s(:defn, type, s(:args, :n), *statement_asts)]
          final << s(:call, nil, :private, s(:lit, type.to_sym)) if access == "private"
          final
        end

        protected

        def rule_to_expression_ast(rule)
          ast_list = []

          RuleParts.list_from_rule_text(rule.rule_text).each do |rule_parts|
            if rule_parts.special_char?
              expr = if rule_parts.special_char == '<'
                if rule.value =~ /\A\d+\z/
                  # "(n / #{rule.value.to_f}).floor"
                  divisor = divisor_for(rule)
                  s(:call,
                    s(:call,
                      s(:call, nil, :n), :/, s(:lit, divisor)
                    ),
                    :floor
                  )
                elsif rule.value == '-x'
                  raise '<< not allowed in negative number rule'
                else
                  # "n.floor"
                  s(:call, s(:call, nil, :n), :floor)
                end
              elsif rule_parts.special_char == '>'
                if rule.value =~ /\./
                  # "n.to_s.gsub(/\d*\./, '').to_f"
                  s(:call,
                    s(:call,
                      s(:call,
                        s(:call, nil, :n),
                      :to_s),
                      :gsub,
                      s(:lit, /d*./),
                      s(:str, "")
                    ),
                  :to_f
                )
                elsif rule.value == '-x'
                  # "-n"
                  s(:call, s(:call, nil, :n), :-@)
                else
                  # "n % divisor"
                  divisor = divisor_for(rule)
                  s(:call, s(:call, nil, :n), :%, s(:lit, divisor))
                end
              elsif rule_parts.special_char == "="
                # "n"
                s(:call, nil, :n)
              end

              if rule_parts.other_format?
                other_format_name = self.class.get_safe_renderer_name(rule_parts.other_format)
                # "#{other_format_name}(#{expr})"
                ast_list << s(:call, nil, other_format_name, expr)
              elsif rule_parts.decimal_format?
                #ast_list << "render_number(expr, :decimal)"
                # "(#{expr}).to_s"
                ast_list << s(:call, expr, :to_s)
              else
                if rule_parts.special_char == '>'
                  # "#{type}(#{expr})"
                  ast_list << s(:call, nil, type, expr)
                elsif rule_parts.special_char == '<'
                  # FIXME: Should be the default rule set for this renderer!
                  # "#{type}(#{expr})"
                  ast_list << s(:call, nil, type, expr)
                else
                  raise "== not supported"
                end
              end
            elsif rule_parts.optional?
              optional_rule_expression_ast = rule_to_expression_ast(
                Rule.new(rule.value, rule_parts.optional, rule.radix)
              )

              # n == #{rule.value.to_i}
              conditions = s(:call,
                s(:call, nil, :n), :==, s(:lit, rule.value.to_i)
              )

              # n == #{rule.value.to_i} || n % 10 == 0
              conditions = if rule_parts.skip_multiple_of_ten?
                s(:or,
                  conditions,
                  s(:call,
                    s(:call, s(:call, nil, :n), :%, s(:lit, 10)), :==, s(:lit, 0)
                  )
                )
              else
                conditions
              end

              # "(conditions ? '' : #{optional_rule_expression_ast})"
              ast_list << s(:if,
                conditions,
                s(:str, ""),
                optional_rule_expression_ast
              )
            elsif rule_parts.literal?
              #"\"#{rule_parts.literal}\""
              ast_list << s(:lit, rule_parts.literal)
            else
              raise "Unknown token in #{rule.rule_text}"
            end
          end

          if ast_list.size == 0
            ast_list = [s(:lit, '')]
          end

          ast = ast_list.first

          (1...ast_list.size).each do |i|
            ast = s(:call, ast, :+, ast_list[i])
          end

          ast
        end

        def divisor_for(rule)
          val = rule.value.to_i
          exp = if val > 0
            (Math.log(val) / Math.log(rule.radix || 10)).ceil
          else
            1
          end

          divisor = exp >= 0 ? rule.radix ** exp : 1
        end

        def condition_to_statement_ast(condition_ast, rule)
          # "if #{condition_ast}; return #{rule_to_expression_ast(rule)}; end"
          s(:if, condition_ast, s(:return, rule_to_expression_ast(rule)), nil)
        end

        def rules
          @rules ||= {}
        end

        def rule_for(value)
          rules[value.to_s]
        end

        def s(*args)
          Sexp.new(*args)
        end
      end

    end
  end
end