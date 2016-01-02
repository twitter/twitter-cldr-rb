# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    autoload :BreakIterator,  'twitter_cldr/segmentation/break_iterator'
    autoload :BreakRule,      'twitter_cldr/segmentation/rule'
    autoload :Cursor,         'twitter_cldr/segmentation/cursor'
    autoload :NoBreakRule,    'twitter_cldr/segmentation/rule'
    autoload :Parser,         'twitter_cldr/segmentation/parser'
    autoload :Rule,           'twitter_cldr/segmentation/rule'
    autoload :RuleSet,        'twitter_cldr/segmentation/rule_set'
    autoload :RuleSetBuilder, 'twitter_cldr/segmentation/rule_set_builder'
  end
end
