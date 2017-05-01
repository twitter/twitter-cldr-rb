# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'open-uri'
require 'fileutils'

module TwitterCldr
  module Resources
    module Requirements

      class EmojiRequirement < UnicodeRequirement
        BASE_URL = "http://unicode.org/Public/emoji/%{version}"

        private

        def product
          'emoji'
        end

        def base_url
          BASE_URL
        end
      end

    end
  end
end
