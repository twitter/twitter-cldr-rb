module TwitterCldr
  module Js
    module Renderers
      class Bundle < Mustache
        self.template_file = File.expand_path(File.join(File.dirname(__FILE__), "..", "mustache/bundle.js"))
      end
    end
  end
end