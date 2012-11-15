# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

include TwitterCldr::Tokenizers

module TwitterCldr
  module Js
    module Renderers
      module Numbers
        class NumbersRenderer < TwitterCldr::Js::Renderers::Base
          self.template_file = File.expand_path(File.join(File.dirname(__FILE__), "../..", "mustache/numbers/numbers.coffee"))

          def tokens
            tokenizer = TwitterCldr::Tokenizers::NumberTokenizer.new(:locale => @locale)
            tokenizer.valid_types.inject({}) do |ret, type|
              ret[type] = {}
              [:positive, :negative].each do |sign|
                ret[type][sign] = case type
                  when :short_decimal, :long_decimal
                    (NumberTokenizer::ABBREVIATED_MIN_POWER..NumberTokenizer::ABBREVIATED_MAX_POWER).inject({}) do |formats, i|
                      formats[10 ** i] = tokenizer.tokens(
                        :sign => sign,
                        :type => type,
                        :format => 10 ** i
                      )
                      formats
                    end
                  else
                    tokenizer.tokens(:sign => sign, :type => type)
                end
              end
              ret
            end.to_json
          end

          def symbols
            TwitterCldr::Tokenizers::NumberTokenizer.new(:locale => @locale).symbols.to_json
          end
        end
      end
    end
  end
end