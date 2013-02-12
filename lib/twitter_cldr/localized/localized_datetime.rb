# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Localized

    class LocalizedDateTime < LocalizedObject
      attr_reader :calendar_type

      def initialize(obj, locale, options = {})
        super
        @calendar_type = options[:calendar_type] || TwitterCldr::DEFAULT_CALENDAR_TYPE
      end

      TwitterCldr::Tokenizers::DateTimeTokenizer::VALID_TYPES.each do |format_type|
        define_method "to_#{format_type}_s" do
          @formatter.format(@base_obj, :type => format_type.to_sym)
        end
      end

      def to_timespan(options = {})
        base_time = options[:base_time] || Time.now
        seconds = (self.to_time.base_obj.to_i - base_time.to_i).abs
        TwitterCldr::Localized::LocalizedTimespan.new(seconds, options.merge(:locale => @locale, :direction => :none))
      end

      def ago(options = {})
        base_time = (options[:base_time] || Time.now).gmtime
        seconds = self.to_time(base_time).base_obj.gmtime.to_i - base_time.to_i
        raise ArgumentError.new('Start date is after end date. Consider using "until" function.') if seconds > 0
        TwitterCldr::Localized::LocalizedTimespan.new(seconds, options.merge(:locale => @locale))
      end

      def until(options = {})
        base_time = (options[:base_time] || Time.now).gmtime
        seconds = self.to_time(base_time).base_obj.gmtime.to_i - base_time.to_i
        raise ArgumentError.new('End date is before start date. Consider using "ago" function.') if seconds < 0
        TwitterCldr::Localized::LocalizedTimespan.new(seconds, options.merge(:locale => @locale))
      end

      def to_s(options = {})
        if options[:format]
          @formatter.format(@base_obj, options.merge(:type => :additional))
        else
          to_default_s
        end
      end

      def to_date
        date = Date.new(@base_obj.year, @base_obj.month, @base_obj.day)
        LocalizedDate.new(date, @locale, :calendar_type => @calendar_type)
      end

      def to_time(base = Time.now)
        utc_dt = @base_obj.new_offset(0)

        time = Time.gm(
          utc_dt.year,
          utc_dt.month,
          utc_dt.day,
          utc_dt.hour,
          utc_dt.min,
          utc_dt.sec,
          utc_dt.sec_fraction * (RUBY_VERSION < '1.9' ? 86400000000 : 1000000)
        )

        LocalizedTime.new(time, @locale, :calendar_type => @calendar_type)
      end

      protected

      def formatter_const
        TwitterCldr::Formatters::DateTimeFormatter
      end
    end

  end
end