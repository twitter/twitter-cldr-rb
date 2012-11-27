# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Js
    module Renderers
      class Bundle < Mustache
        self.template_path = File.expand_path(File.join(File.dirname(__FILE__), "..", "mustache"))
        self.template_file = File.join(self.template_path, "bundle.coffee")
        self.template_extension = "coffee"

        def version
          TwitterCldr::Js::VERSION
        end

        def is_rtl?
          TwitterCldr::Shared::Languages.is_rtl?(self[:locale])
        end
      end
    end
  end
end