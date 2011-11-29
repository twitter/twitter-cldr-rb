module TwitterCldr
  module Format
    class Datetime
      class Base
        attr_reader :calendar

        def initialize(format, calendar)
          @calendar = calendar
          compile(format)
        end

        protected

          def compile(format)
            (class << self; self; end).class_eval <<-code
              def apply(date, options = {}); #{compile_format(format)}; end
            code
          end

          # compile_format("EEEE, d. MMMM y") # =>
          #   '' + weekday(date, "EEEE", 4) + ', ' + day(date, "d", 1) + '. ' +
          #        month(date, "MMMM", 4)   + ' ' + year(date, "y", 1) + ''
          def compile_format(format)
            "'" + format.gsub(self.class.const_get(:PATTERN)) do |token|
              method = self.class.const_get(:METHODS)[token[0, 1]]
              "' + #{method}(date, #{token.inspect}, #{token.length}) + '"
            end + "'"
          end
      end
    end
  end
end