# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared

    class UnsupportedNumberingSystemError < StandardError; end

    class NumberingSystem

      class << self
        def for_name(name)
          system_cache[name] ||= begin
            if system = resource[name.to_sym]
              if system[:type] != "numeric"
                raise UnsupportedNumberingSystemError.new("#{system[:type]} numbering systems not supported.")
              else
                new(system[:name], system[:digits])
              end
            end
          end
        end

        protected

        def system_cache
          @system_cache ||= {}
        end

        def resource
          @resource ||= TwitterCldr.get_resource(:shared, :numbering_systems)[:numbering_systems]
        end
      end

      attr_reader :name, :digits

      def initialize(name, digits)
        @name = name
        @digits = split_digits(digits)
      end

      def transliterate(number)
        number.to_s.gsub(/\d/) do |digit|
          digits[digit.to_i]
        end
      end

      protected

      def split_digits(str)
        str.unpack("U*").map { |digit| [digit].pack("U*") }
      end

    end
  end
end