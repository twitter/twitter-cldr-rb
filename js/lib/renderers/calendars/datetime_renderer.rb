module TwitterCldr
  module Js
    module Renderers
      module Calendars
        class DateTimeRenderer < Mustache
          self.template_file = File.expand_path(File.join(File.dirname(__FILE__), "../..", "mustache/calendars/datetime.coffee"))

          def initialize(options = {})
            @locale = options[:locale]
          end

          def tokens
            tokenizer = TwitterCldr::Tokenizers::DateTimeTokenizer.new(:locale => @locale)
            TwitterCldr::Tokenizers::DateTimeTokenizer::VALID_TYPES.inject({}) do |ret, type|
              ret[type] = tokenizer.tokens(:type => type).map(&:to_hash)
              ret
            end.to_json
          end

          def calendar
            TwitterCldr.resources.resource_for(@locale, "calendars")[TwitterCldr.convert_locale(@locale)][:calendars][:gregorian].to_json
          end
        end
      end
    end
  end
end