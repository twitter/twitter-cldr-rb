# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    class RuleSet

      class << self
        def create(locale, boundary_type, options = {})
          new(locale, StateMachine.instance(boundary_type, locale), options)
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

        # Let the state machine find the first boundary for the line
        # boundary type. This helps pass nearly all the Unicode
        # segmentation tests, so it must be the right thing to do.
        # Normally the first boundary is the implicit start of text
        # boundary, but potentially not for the line rules?
        yield 0 unless state_machine.boundary_type == 'line'

        until cursor.eos?
          state_machine.handle_next(cursor)
          yield cursor.position if suppressions.should_break?(cursor)
        end
      end

      def boundary_type
        state_machine.boundary_type
      end

      private

      def suppressions
        @suppressions ||= if use_uli_exceptions?
          Suppressions.instance(boundary_type, locale)
        else
          NullSuppressions.instance
        end
      end
    end
  end
end
