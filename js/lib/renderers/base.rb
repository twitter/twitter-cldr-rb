# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Js
    module Renderers
      class Base < Mustache

        def initialize(options = {})
          @locale = options[:locale]
        end

      end
    end
  end
end