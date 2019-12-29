# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Segmentation
    class LineIterator < SegmentIterator
      def each_boundary(&block)
        # Let the state machine find the first boundary for the line
        # boundary type (i.e. don't yield 0 here). This helps pass
        # nearly all the Unicode segmentation tests, so it must be
        # the right thing to do. Normally the first boundary is the
        # implicit start of text boundary, but potentially not for
        # the line rules?
        rule_set.each_boundary(cursor, &block)
      end
    end
  end
end
