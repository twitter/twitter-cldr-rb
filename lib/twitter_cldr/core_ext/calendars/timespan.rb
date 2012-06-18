# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  class LocalizedTimespan < LocalizedObject

    def initialize(seconds, locale)
      @formatter = TwitterCldr::Formatters::TimespanFormatter.new(:locale => locale)
      @seconds = seconds
    end

    def to_s(unit = :default)
      @formatter.format(@seconds, unit)
    end

    protected

    def formatter_const
      TwitterCldr::Formatters::TimespanFormatter
    end
  end
end