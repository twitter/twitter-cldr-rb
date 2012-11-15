# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Js
    module Renderers
      module Calendars
        class DateTimeRenderer < TwitterCldr::Js::Renderers::Base
          self.template_file = File.expand_path(File.join(File.dirname(__FILE__), "../..", "mustache/calendars/datetime.coffee"))

          def tokens
            { :date_time => TwitterCldr::Tokenizers::DateTimeTokenizer,
              :time => TwitterCldr::Tokenizers::TimeTokenizer,
              :date => TwitterCldr::Tokenizers::DateTokenizer }.inject({}) do |tokens, (name, const)|
              tokenizer = const.new(:locale => @locale)
              tokens[name] = const::VALID_TYPES.inject({}) do |ret, type|
                ret[type] = if type == :additional
                  pattern_list = TwitterCldr.get_locale_resource(@locale, :calendars)[@locale][:calendars]
                  pattern_list = pattern_list[tokenizer.calendar_type][:additional_formats].keys
                  pattern_list.inject({}) do |additionals, pattern|
                    additionals[pattern] = tokenizer.tokens(:type => type, :format => pattern.to_s).map(&:to_hash)
                    additionals
                  end
                else
                  tokenizer.tokens(:type => type).map(&:to_hash)
                end
                ret
              end
              tokens
            end.to_json
          end
        end
      end
    end
  end
end