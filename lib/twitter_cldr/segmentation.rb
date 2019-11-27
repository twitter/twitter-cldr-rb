# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    autoload :BreakIterator, 'twitter_cldr/segmentation/break_iterator'
    autoload :Cursor,        'twitter_cldr/segmentation/cursor'
    autoload :Metadata,      'twitter_cldr/segmentation/metadata'
    autoload :RuleSet,       'twitter_cldr/segmentation/rule_set'
    autoload :StateMachine,  'twitter_cldr/segmentation/state_machine'
    autoload :StateTable,    'twitter_cldr/segmentation/state_table'
    autoload :StatusTable,   'twitter_cldr/segmentation/status_table'
    autoload :Trie,          'twitter_cldr/segmentation/trie'
  end
end
