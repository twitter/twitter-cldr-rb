# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'ruby_parser'

module TwitterCldr
  module Js
    module Renderers
      module PluralRules

        class PluralRulesCompiler

          class << self
            def rule_to_js(rule_code)
              tree = RubyParser.new.parse(rule_code).to_a
              "function(n) { return #{statement_list(tree)} }"
            end

            protected

            def statement_list(tree)
              if tree.first == :block
                tree[1..-1].map { |sub_tree| send(:"_#{sub_tree.first}", sub_tree) }.join(" ")
              else
                send(:"_#{tree.first}", tree)
              end
            end

            def _if(tree)
              result = "(function() { if (#{statement_list(tree[1])}) { return #{statement_list(tree[2])} }"
              result << " else { return #{statement_list(tree[3])} }" if tree[3]
              "#{result} })();"
            end

            def _lvar(tree)
              tree.first.to_s
            end

            def _call(tree)
              case tree[2]
                when :==, :%, :<, :>  # special operators that actually resolve to method calls
                  "#{statement_list(tree[1])} #{tree[2]} #{statement_list(tree[3])}"
                when :include?
                  "#{statement_list(tree[1])}.indexOf(#{statement_list(tree[3])}) >= 0"
                else
                  # this should be the only case where tree[1] might be nil (i.e. the method was not called on any object)
                  call = tree[1] ? "#{statement_list(tree[1])}.#{tree[2]}" : tree[2].to_s
                  arglist = statement_list(tree[3])
                  arglist == "" ? call : "#{call}(#{arglist})"
              end
            end

            def _arglist(tree)
              tree[1..-1].map { |arg| statement_list(arg) }.join(", ")
            end

            def _lit(tree)
              if tree[1].is_a?(Symbol) || tree[1].is_a?(String)
                "\"#{tree[1]}\""
              else
                tree[1]
              end
            end

            def _array(tree)
              "[#{tree[1..-1].map { |arg| statement_list(arg) }.join(", ")}]"
            end

            def _not(tree)
              "!(#{statement_list(tree[1])})"
            end

            def _and(tree)
              "#{statement_list(tree[1])} && #{statement_list(tree[2])}"
            end

            def _or(tree)
              "#{statement_list(tree[1])} || #{statement_list(tree[2])}"
            end
          end

        end

      end
    end
  end
end