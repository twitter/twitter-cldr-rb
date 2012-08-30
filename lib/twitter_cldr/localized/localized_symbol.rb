# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Localized

    class LocalizedSymbol < LocalizedObject
      def as_language_code
        TwitterCldr::Shared::Languages.from_code_for_locale(@base_obj, @locale)
      end

      def formatter_const
        nil
      end
    end

  end
end