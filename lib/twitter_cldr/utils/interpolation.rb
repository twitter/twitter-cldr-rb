# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

# The implementation of the TwitterCldr.interpolate method that backports String interpolation capabilities
# (originally implemented in String#% method) from Ruby 1.9 to Ruby 1.8 is heavily influenced by the
# implementation of the same feature in i18n (https://github.com/svenfuchs/i18n/blob/89ea337f48562370988421e50caa7c2fe89452c7/lib/i18n/core_ext/string/interpolate.rb)
# and gettext (https://github.com/mutoh/gettext/blob/11b8c1525ba9f00afb1942f7ebf34bec12f7558b/lib/gettext/core_ext/string.rb) gems.
#
# See NOTICE file for corresponding license agreements.


# KeyError is raised during interpolation when there is a placeholder that doesn't have corresponding key in the
# interpolation hash. KeyError is defined in 1.9. We define it for prior versions of Ruby to have the same behavior.
#
class KeyError < IndexError
  def initialize(message = nil)
    super(message || 'key not found')
  end
end unless defined?(KeyError)


module TwitterCldr
  module Utils

    HASH_INTERPOLATION_REGEXP = Regexp.union(
        /%\{(\w+)\}/,
        /%<(\w+)>(.*?\d*\.?\d*[bBdiouxXeEfgGcps])/
    )

    HASH_INTERPOLATION_WITH_ESCAPE_REGEXP = Regexp.union(
        /%%/,
        HASH_INTERPOLATION_REGEXP
    )

    class << self

      # Uses +string+ as a format specification and returns the result of applying it to +args+.
      #
      # There are three ways to use it:
      #
      # * Using a single argument or Array of arguments.
      #
      #   This is the default behaviour of the String#% method. See Kernel#sprintf for more details about the format
      #   specification.
      #
      #   Example:
      #
      #     TwitterCldr::Utils.interpolate('%d %s', [1, 'message'])
      #     # => "1 message"
      #
      # * Using a Hash as an argument and unformatted, named placeholders (Ruby 1.9 syntax).
      #
      #   When you pass a Hash as an argument and specify placeholders with %{foo} it will interpret the hash values as
      #   named arguments.
      #
      #   Example:
      #
      #     TwitterCldr::Utils.interpolate('%{firstname}, %{lastname}', :firstname => 'Masao', :lastname => 'Mutoh')
      #     # => "Masao Mutoh"
      #
      # * Using a Hash as an argument and formatted, named placeholders (Ruby 1.9 syntax).
      #
      #   When you pass a Hash as an argument and specify placeholders with %<foo>d  it will interpret the hash values
      #   as named arguments and format the value according to the formatting instruction appended to the closing >.
      #
      #   Example:
      #
      #     TwitterCldr::Utils.interpolate('%<integer>d, %<float>.1f', :integer => 10, :float => 43.4)
      #     # => "10, 43.3"
      #
      # An exception can be thrown in two cases when Ruby 1.9 interpolation syntax is used:
      #
      # * ArgumentError is thrown if Ruby 1.9. interpolation syntax is used in +string+, but +args+ is not a Hash;
      # * KeyError is thrown if the value for one of the placeholders in +string+ is missing in +args+ hash.
      #
      def interpolate(string, args)
        string =~ HASH_INTERPOLATION_REGEXP ? interpolate_hash(string, args) : interpolate_value_or_array(string, args)
      end

      private

      def interpolate_hash(string, args)
        raise ArgumentError.new('expected a Hash') unless args.is_a?(Hash)

        string.gsub(HASH_INTERPOLATION_WITH_ESCAPE_REGEXP) do |match|
          if match == '%%'
            '%'
          else
            key = ($1 || $2).to_sym
            raise KeyError unless args.has_key?(key)
            $3 ? sprintf("%#{$3}", args[key]) : args[key]
          end
        end
      end

      def interpolate_value_or_array(string, args)
        string.gsub(/%([{<])/, '%%\1') % args
      end

    end

  end
end