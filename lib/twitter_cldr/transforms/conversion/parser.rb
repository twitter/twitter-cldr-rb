# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    class Conversion < Rule

      class Parser < TwitterCldr::Parsers::Parser
        private

        #            <>
        #        /        \
        #     context    context
        #    /  |    \   /  |   \
        #   a  revst  d e revst  h
        #       /  \       /  \
        #      b    c     f    g
        #
        # a { b | c } d <> e { f | g } h ;
        # left_before_context { left_text_to_replace | left_revisit } left_after_context
        # <>
        # right_before_context { right_text_to_replace | right_revisit } right_after_context ;
        def do_parse(options)
          first_side = side
          direction = get_direction_from(current_token)
          next_token(:direction)
          second_side = side
          DirectionNode.new(direction, first_side, second_side)
        end

        def side
          cur_context = nil
          operand_stack = []
          operator_stack = []

          until current_token.type == :direction || current_token.type == :semicolon
            operand_stack.push(next_token_cluster)
            conditional_combine(operand_stack, operator_stack)

            case current_token.type
              when :before_context
                cur_context = before_context(
                  operand_stack, operator_stack
                )
              when :after_context
                cur_context = after_context(
                  cur_context, operand_stack, operator_stack
                )
              when :cursor
                cursor(operand_stack, operator_stack)
            end
          end

          combine(operand_stack, operator_stack)
          operand_stack.pop
        end

        def before_context(operand_stack, operator_stack)
          operator_stack.push(
            Context.new(operand_stack.pop)
          )

          next_token(:before_context)
          operator_stack.last
        end

        def after_context(cur_context, operand_stack, operator_stack)
          unless cur_context
            operator_stack.push(
              Context.new(nil, operand_stack.pop)
            )
          end

          next_token(:after_context)
          operator_stack.last
        end

        def cursor(operand_stack, operator_stack)
          operator_stack.push(current_token.type)
          next_token(:cursor)
        end

        def conditional_combine(operand_stack, operator_stack)
          if !operator_stack.empty? && operand_stack.size >= 2
            combine(operand_stack, operator_stack)
          end
        end

        def combine(operand_stack, operator_stack)
          if cur_operator = operator_stack.pop
            if cur_operator.is_a?(Context)
              until cur_operator.full?
                cur_operator.push(operand_stack.pop || [])
              end

              operand_stack.push(cur_operator)
            else
              right = operand_stack.pop
              left = operand_stack.pop

              operand_stack.push(
                Node.new(cur_operator, left, right)
              )
            end
          end
        end

        def next_token_cluster
          tokens = []

          until is_operator?(current_token) || current_token.type == :semicolon
            tokens << current_token
            next_token(current_token.type)
          end

          tokens
        end

        def is_operator?(token)
          case token.type
            when :direction, :after_context, :before_context, :cursor
              true
            else
              false
          end
        end

        def get_direction_from(token)
          case token.value
            when '>'
              :forward
            when '<'
              :backward
            when '<>'
              :bidirectional
          end
        end
      end

    end
  end
end
