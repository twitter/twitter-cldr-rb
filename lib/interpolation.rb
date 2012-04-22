# encoding: UTF-8

# KeyError is raised during interpolation when there is a placeholder that doesn't have corresponding key in the
# interpolation hash. KeyError is defined in 1.9. We define it for prior versions of Ruby to have the same behavior.
class KeyError < IndexError
  def initialize(message = nil)
    super(message || 'key not found')
  end
end unless defined?(KeyError)


module TwitterCldr

  HASH_INTERPOLATION_REGEXP = Regexp.union(
      /%\{(\w+)\}/,
      /%<(\w+)>(.*?\d*\.?\d*[bBdiouxXeEfgGcps])/
  )

  HASH_INTERPOLATION_WITH_ESCAPE_REGEXP = Regexp.union(
      /%%/,
      HASH_INTERPOLATION_REGEXP
  )

  class << self

    def interpolate(string, args)
      string =~ HASH_INTERPOLATION_REGEXP ? interpolate_hash(string, args) : interpolate_value_or_array(string, args)
    end

    private

    def interpolate_hash(string, args)
      raise ArgumentError unless args.is_a?(Hash)

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