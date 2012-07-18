# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  class LocalizedTimespan < LocalizedObject

    def initialize(seconds, options = {})
      super(seconds, options[:locale], options)
      @formatter = TwitterCldr::Formatters::TimespanFormatter.new(options)
    end

    def to_s(options = {})
      @formatter.format(@base_obj, options)
    end

    protected

    def formatter_const
      TwitterCldr::Formatters::TimespanFormatter
    end
  end
end