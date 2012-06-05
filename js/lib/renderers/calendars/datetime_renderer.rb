# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

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
            tokens = {}
            { :date_time => TwitterCldr::Tokenizers::DateTimeTokenizer,
              :time => TwitterCldr::Tokenizers::TimeTokenizer,
              :date => TwitterCldr::Tokenizers::DateTokenizer }.each_pair do |name, const|
              tokenizer = const.new(:locale => @locale)
              tokens[name] = const::VALID_TYPES.inject({}) do |ret, type|
                ret[type] = tokenizer.tokens(:type => type).map(&:to_hash)
                ret
              end
            end
            tokens.to_json
          end

          def calendar
            TwitterCldr.get_locale_resource(@locale, "calendars")[TwitterCldr.convert_locale(@locale)][:calendars][:gregorian].to_json
          end
        end
      end
    end
  end
end