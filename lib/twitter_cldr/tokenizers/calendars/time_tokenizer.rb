# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class TimeTokenizer < TwitterCldr::Tokenizers::DateTimeTokenizer
      TOKEN_SPLITTER_REGEX = /(\'[\w\s-]+\'|a{1}|h{1,2}|H{1,2}|K{1,2}|k{1,2}|m{1,2}|s{1,2}|S+|z{1,4}|Z{1,4})/
      TOKEN_TYPE_REGEXES = {
        :pattern   => { :regex => /^(a{1}|h{1,2}|H{1,2}|K{1,2}|k{1,2}|m{1,2}|s{1,2}|S+|z{1,4}|Z{1,4})/, :priority => 1 },
        :plaintext => { :regex => //, :priority => 2 }
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
          :default    => [:formats, :time, :default],
          :full       => [:formats, :time, :full],
          :long       => [:formats, :time, :long],
          :medium     => [:formats, :time, :medium],
          :short      => [:formats, :time, :short],
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