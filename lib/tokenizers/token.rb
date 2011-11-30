module TwitterCldr
  module Tokenizers
    class Token
      attr_accessor :start, :finish, :value, :type

      def initialize(options = {})
        options.each_pair do |key, val|
          self.send("#{key.to_s}=", val)
        end
      end
    end
  end
end