# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    class RuleSet

      class << self
        def create(locale, boundary_type, options = {})
          new(locale, StateMachine.instance(boundary_type), options)
        end
      end

      attr_reader :locale, :state_machine
      attr_accessor :use_uli_exceptions

      alias_method :use_uli_exceptions?, :use_uli_exceptions

      def initialize(locale, state_machine, options)
        @locale = locale
        @state_machine = state_machine
        @use_uli_exceptions = options.fetch(
          :use_uli_exceptions, false
        )
      end

      def each_boundary(str)
        return to_enum(__method__, str) unless block_given?

        cursor = Cursor.new(str)
        yield 0

        until cursor.eos?
          state_machine.handle_next(cursor)
          yield cursor.position
        end
      end
    end
  end
end
