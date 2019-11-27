# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'base64'
require 'singleton'

module TwitterCldr
  module Segmentation
    class StateMachine
      include Singleton

      START_STATE = 1
      STOP_STATE = 0
      NEXT_STATES = 4
      ACCEPTING = 0
      TAG_IDX = 2
      LOOKAHEAD = 1

      class << self
        def instance(boundary_type)
          cache[boundary_type] ||= begin
            rsrc = resource_for(boundary_type)

            new(
              boundary_type,
              Metadata.new(rsrc[:metadata]),
              StateTable.load16(rsrc[:forward_table]),
              StateTable.load16(rsrc[:backward_table]),
              StatusTable.load(rsrc[:status_table]),
              Trie.load16(rsrc[:trie])
            )
          end
        end

        private

        def resource_for(boundary_type)
          TwitterCldr.get_resource('shared', 'segments', boundary_type)
        end

        def cache
          @cache ||= {}
        end
      end

      attr_reader :boundary_type, :metadata, :ftable, :rtable, :status_table, :trie

      def initialize(boundary_type, metadata, ftable, rtable, status_table, trie)
        @boundary_type = boundary_type
        @metadata = metadata
        @ftable = ftable
        @rtable = rtable
        @status_table = status_table
        @trie = trie
      end

      def handle_next(cursor)
        result = initial_position = cursor.position
        state = START_STATE
        row = row_index_for(state)
        category = 2
        mode = :run

        until state == STOP_STATE
          if cursor.eos?
            break if mode == :stop
            mode = :stop
            category = 1
          else
            category = trie.get(cursor.codepoint)

            if (category & 0x4000) != 0
              category &= ~0x4000
            end

            cursor.advance
          end

          state = ftable[row + NEXT_STATES + category]
          row = row_index_for(state)

          if ftable[row + ACCEPTING] == -1
            # match found
            result = cursor.position
            @rule_status_idx = ftable[row + TAG_IDX]
          end

          # completed_rule = ftable[row + LOOKAHEAD]

          # if completed_rule > 0
          #   puts "GOT HERE"
          # end
        end

        cursor.position = result

        # don't let cursor get stuck
        if cursor.position == initial_position
          cursor.advance
        end

        result
      end

      private

      def row_index_for(state)
        state * (metadata.category_count + 4)
      end
    end
  end
end
