module TwitterCldr
  module Format
    class Datetime
      autoload :Base, 'cldr/format/datetime/base'

      attr_reader :date, :time

      def initialize(format, date, time)
        @date, @time = date, time
        compile(format)
      end

      protected

        def compile(format)
          (class << self; self; end).class_eval <<-code
            def apply(datetime, options = {}); #{compile_format(format)}; end
          code
        end
        
        def compile_format(format)
          "'" + format.gsub(%r(\{(0|1)\})) do |token|
            "' + #{token == '{0}' ? 'time' : 'date'}.apply(datetime, options) + '"
          end + "'"
        end
    end
  end
end