# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Js
    module Renderers
      module Shared
        class CalendarRenderer < TwitterCldr::Js::Renderers::Base
          self.template_file = File.expand_path(File.join(File.dirname(__FILE__), "../..", "mustache/shared/calendar.coffee"))

          def calendar
            TwitterCldr::Tokenizers::DateTimeTokenizer.new(:locale => @locale).calendar.to_json
          end
        end
      end
    end
  end
end