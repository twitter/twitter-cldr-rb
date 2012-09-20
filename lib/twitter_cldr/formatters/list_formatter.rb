# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    class ListFormatter < Base

      def initialize(options = {})
        @locale = TwitterCldr.convert_locale(extract_locale(options))
      end

      def format(list)
        if resource.include?(list.size)
          compose(resource[list.size], list)
        else
          compose_list(list)
        end
      end

      protected

      def compose_list(list)
        result = compose(resource[:end], [list[-2], list[-1]])

        # Ruby ranges don't support subtraction for some reason (eg. -3..-5).
        # Instead, we use a positive counter and negate it on array access.
        (3..list.size).each do |i|
          format_sym = i == list.size ? :start : :middle
          format_sym = :middle unless resource.include?(format_sym)
          result = compose(resource[format_sym], [list[-i], result])
        end

        result
      end

      def compose(format, elements)
        elements.compact!

        if elements.size > 1
          result = format.dup
          elements.size.times { |i| result.gsub!("{#{i}}", elements[i]) }
          result
        else
          elements[0]
        end
      end

      def resource
        @resource ||= TwitterCldr.get_locale_resource(@locale, :lists)[@locale][:lists]
      end

    end
  end
end