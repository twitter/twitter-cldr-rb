# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'rails'
require 'twitter_cldr'
require 'json'
require 'rake'

require 'twitter_cldr/js/version'

module TwitterCldr
  module Js
    autoload :Compiler,  "twitter_cldr/js/compiler"
    autoload :Renderers, "twitter_cldr/js/renderers"
    autoload :Tasks,     "twitter_cldr/js/tasks/tasks"

    class Engine < ::Rails::Engine
    end

    class Railtie < ::Rails::Railtie
      rake_tasks do
        load "twitter_cldr/js/tasks/tasks.rake"
      end
    end
  end
end