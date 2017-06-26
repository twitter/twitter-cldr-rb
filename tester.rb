require 'twitter_cldr'
require 'pry-nav'

regex = TwitterCldr::Shared::UnicodeRegex.compile("[[\\p{Emoji}]-[\\p{Word_Break=Regional_Indicator}\\u002a\\u00230-9©®™〰〽]]")
puts regex.to_regexp
