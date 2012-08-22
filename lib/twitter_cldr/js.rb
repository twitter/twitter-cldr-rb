# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

$:.push(File.join(File.dirname(__FILE__), "js"))

require 'rails'
require 'twitter_cldr'
require 'mustache'
require 'json'
require 'uglifier'
require 'coffee-script'
require 'rake'
require 'twitter_cldr/tasks'

require 'compiler'
require 'renderers'
require 'version'

module TwitterCldr
  module Js
    class Engine < ::Rails::Engine
    end
  end
end