# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    autoload :BreakIterator,    'twitter_cldr/segmentation/break_iterator'
    autoload :CategoryTable,    'twitter_cldr/segmentation/category_table'
    autoload :Cursor,           'twitter_cldr/segmentation/cursor'
    autoload :Metadata,         'twitter_cldr/segmentation/metadata'
    autoload :NullSuppressions, 'twitter_cldr/segmentation/null_suppressions'
    autoload :RuleSet,          'twitter_cldr/segmentation/rule_set'
    autoload :StateMachine,     'twitter_cldr/segmentation/state_machine'
    autoload :StateTable,       'twitter_cldr/segmentation/state_table'
    autoload :StatusTable,      'twitter_cldr/segmentation/status_table'
    autoload :Suppressions,     'twitter_cldr/segmentation/suppressions'
  end
end
