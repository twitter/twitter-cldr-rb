# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module Rbnf

      class UnexpectedTokenError < StandardError; end

      class RuleParser

        def reset
          @token_index = 0
        end

        def parse(tokens)
          @tokens = tokens
          reset
          switch([])
        end

        private

        def switch(list)
          send(current_token.type, list)
        end

        def equals(list)
          contents = descriptor(current_token)
          list << Substitution.new(:equals, contents, 2)
          next_token(:equals)
          switch(list)
        end

        def left_arrow(list)
          contents = descriptor(current_token)
          list << Substitution.new(:left_arrow, contents, 2)
          next_token(:left_arrow)
          switch(list)
        end

        def right_arrow(list)
          contents = descriptor(current_token)
          sub = Substitution.new(:right_arrow, contents, 2)
          next_token(:right_arrow)

          # handle >>> case
          if current_token.type == :right_arrow
            sub.length += 1
            next_token(:right_arrow)
          end

          list << sub
          switch(list)
        end

        def plaintext(list)
          add_and_advance(list)
        end

        def open_bracket(list)
          add_and_advance(list)
        end

        def close_bracket(list)
          add_and_advance(list)
        end

        def semicolon(list)
          list
        end

        def add_and_advance(list)
          list << current_token
          next_token(current_token.type)
          switch(list)
        end

        def descriptor(token)
          next_token(token.type)
          contents = []
          until current_token.type == token.type
            contents << current_token
            next_token(current_token.type)
          end
          contents
        end

        def next_token(type)
          unless current_token.type == type
            raise UnexpectedTokenError.new("Unexpected token #{current_token.type} \"#{current_token.value}\"")
          end

          @token_index += 1

          while empty?(current_token)
            @token_index += 1
          end

          current_token
        end

        def empty?(token)
          token.type == :plaintext && token.value == ""
        end

        def current_token
          @tokens[@token_index]
        end

      end
    end
  end
end