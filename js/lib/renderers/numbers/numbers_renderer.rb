# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Js
    module Renderers
      module Numbers
        class NumbersRenderer < TwitterCldr::Js::Renderers::Base
          self.template_file = File.expand_path(File.join(File.dirname(__FILE__), "../..", "mustache/numbers/numbers.coffee"))

          def tokens
            TwitterCldr::Tokenizers::NumberTokenizer::VALID_TYPES.inject({}) do |ret, type|
              tokenizer = TwitterCldr::Tokenizers::NumberTokenizer.new(:type => type, :locale => @locale)
              ret[type] = {}
              [:positive, :negative].each do |sign|
                ret[type][sign] = tokenizer.tokens(:sign => sign)
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