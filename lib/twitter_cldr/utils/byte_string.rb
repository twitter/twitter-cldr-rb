# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'forwardable'

module TwitterCldr
  module Utils

    class ByteString
      attr_reader :string, :original_encoding
      @@ruby_indexes_bytes = !''.respond_to?(:encoding)

      def initialize(string)
        @string = string

        unless @@ruby_indexes_bytes
          @original_encoding = string.encoding
          @string.force_encoding(
            Encoding::ASCII_8BIT
          )
        end
      end

      def [](idx)
        start = start_for(idx)
        stop = end_for(idx)

        if @@ruby_indexes_bytes
          string[start..(stop - 1)]
        else
          string.byteslice(start, stop - start)
        end
      end

      def []=(idx, str)
        if (strsize = sizeof(str)) > 0
          start = start_for(idx)
          stop = end_for(idx)

          if start == stop && strsize == 1
            setbyte(start, _getbyte(str, 0))
          else
            insert_bytes(
              start, str, sizeof(str) - ((stop - start) + 1)
            )
          end
        end
      end

      def length
        sizeof(string)
      end

      alias :size :length

      def to_s
        if @@ruby_indexes_bytes
          string
        else
          string.force_encoding(original_encoding)
        end
      end

      def delete_at(pos, length = 1)
        # we can do this because the string is ASCII-encoded
        string[pos...(pos + length)] = ''
      end

      def setbyte(pos, byte)
        _setbyte(string, pos, byte)
      end

      def getbyte(pos)
        _getbyte(string, pos)
      end

      def scan(*args)
        string.scan(*args) do
          yield Regexp.last_match if block_given?
        end
      end

      def index(*args, &block)
        string.index(*args, &block)
      end

      def self.sizeof(str)
        @ruby_indexes_bytes ? str.size : str.bytesize
      end

      protected

      def _setbyte(str, pos, byte)
        unless byte.is_a?(Fixnum)
          raise ArgumentError, 'byte must be a Fixnum'
        end

        if @@ruby_indexes_bytes
          str[pos] = byte
        else
          str.setbyte(pos, byte)
        end
      end

      def _getbyte(str, pos)
        if @@ruby_indexes_bytes
          str[pos]
        else
          str.getbyte(pos)
        end
      end

      def sizeof(str)
        @@ruby_indexes_bytes ? str.size : str.bytesize
      end

      def start_for(num)
        case num
          when Fixnum
            num
          when Range
            num.first
        end
      end

      def end_for(num)
        case num
          when Fixnum
            num
          when Range
            if num.exclude_end?
              num.last - 1
            else
              num.last
            end
        end
      end

      # pos = position to start at
      # new_str = new string to insert
      # extra_width = number of new bytes to add (may cause overlap if
      #   new_str is longer than extra_width).
      def insert_bytes(pos, new_str, extra_width)
        # increase length of string by n bytes
        if extra_width > 0
          string << ('a' * extra_width)

          # shift characters
          (size - 1).downto(pos) do |i|
            setbyte(i, getbyte(i - extra_width))
          end
        else
          delete_at(pos, extra_width.abs)
        end

        # insert new bytes
        0.upto(sizeof(new_str) - 1) do |i|
          setbyte(pos + i, _getbyte(new_str, i))
        end
      end
    end

  end
end
