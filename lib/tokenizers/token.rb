module TwitterCldr
  module Tokenizers
    class Token
      attr_accessor :value, :type

      def initialize(options = {})
        options.each_pair do |key, val|
          self.send("#{key.to_s}=", val)
        end
      end

      def to_s
        @value
      end

      def to_hash
        { :value => @value, :type => @type }
      end
    end
  end
end