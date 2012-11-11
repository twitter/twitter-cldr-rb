# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class DateTokenizer < TwitterCldr::Tokenizers::DateTimeTokenizer
      TOKEN_SPLITTER_REGEX = /(\s*\'[\w\s-]+\'\s*|G{1,5}|y+|Y+|Q{1,4}|q{1,5}|M{1,5}|L{1,5}|d{1,2}|F{1}|E{1,5}|e{1,5}|c{1,5}|\#\{[^\}]+\})/
      TOKEN_TYPE_REGEXES = {
        :composite => { :regex => /^\#\{[^\}]+\}/, :content => /^\#\{([^\}]+)\}/ },
        :pattern   => { :regex => /^(?:G{1,5}|y+|Y+|Q{1,4}|q{1,5}|M{1,5}|L{1,5}|d{1,2}|F{1}|E{1,5}|e{1,5}|c{1,5})/ },
        :plaintext => { :regex => // }
      }

      def initialize(options = {})
        super(options)

        @token_splitter_regexes = {
          :else => TOKEN_SPLITTER_REGEX
        }

        @token_type_regexes = {
          :else => TOKEN_TYPE_REGEXES
        }

        @paths = {
          :default    => [:formats, :date, :default],
          :full       => [:formats, :date, :full],
          :long       => [:formats, :date, :long],
          :medium     => [:formats, :date, :medium],
          :short      => [:formats, :date, :short],
          :additional => [:additional_formats]
        }
      end

      protected

      # must override this because DateTimeTokenizer will set them otherwise
      def init_placeholders
        @placeholders = {}
      end
    end
  end
end