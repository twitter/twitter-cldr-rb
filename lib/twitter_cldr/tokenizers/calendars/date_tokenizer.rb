# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class DateTokenizer < TwitterCldr::Tokenizers::DateTimeTokenizer
      def initialize(options = {})
        super(options)
        @token_splitter_regex = /(\s*\'[\w\s-]+\'\s*|G{1,5}|y+|Y+|Q{1,4}|q{1,5}|M{1,5}|L{1,5}|d{1,2}|F{1}|E{1,5}|e{1,5}|c{1,5}|\#\{[^\}]+\})/

        @token_type_regexes = [
            { :type => :composite, :regex => /^\#\{[^\}]+\}/, :content => /^\#\{([^\}]+)\}/ },
            { :type => :pattern,   :regex => /^(?:G{1,5}|y+|Y+|Q{1,4}|q{1,5}|M{1,5}|L{1,5}|d{1,2}|F{1}|E{1,5}|e{1,5}|c{1,5})/ },
            { :type => :plaintext, :regex => // }
        ]

        @paths = {
            :default => [:formats, :date, :default],
            :full    => [:formats, :date, :full],
            :long    => [:formats, :date, :long],
            :medium  => [:formats, :date, :medium],
            :short   => [:formats, :date, :short]
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