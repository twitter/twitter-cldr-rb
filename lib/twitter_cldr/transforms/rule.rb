# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    # Base class for all transform rules
    class Rule
      class << self
        def unescape(text)
          # For a real space in the rules, place quotes around it.
          # For a real backslash, either double it \\, or quote it '\'.
          # For a real single quote, double it '', or place a backslash before it \'.
          # (Remove superfluous spaces. spaces have no meaning unless they're escaped).
          text
            .gsub(/([^']) ([^'])/) { "#{$1}#{$2}" }  # remove superfluous spaces
            .gsub(/([^']) ([^'])/) { "#{$1}#{$2}" }  # second time to get missed spaces
            .gsub("' '", ' ')
            .gsub('\\\\', '\\')
            .gsub("'\\'", '\\')
            .gsub("''", "'")
            .gsub("\\'", "'")
        end
      end
    end

  end
end
