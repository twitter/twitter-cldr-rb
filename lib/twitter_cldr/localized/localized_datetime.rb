# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'tzinfo'

module TwitterCldr
  module Localized

    class LocalizedDateTime < LocalizedObject
      attr_reader :calendar_type, :timezone

      def initialize(obj, locale, options = {})
        super
        @calendar_type = options[:calendar_type] || TwitterCldr::DEFAULT_CALENDAR_TYPE
        @timezone = options[:timezone] || "UTC"
      end

      # TwitterCldr::Tokenizers::DateTimeTokenizer::VALID_TYPES.each do |format_type|
      #   define_method "to_#{format_type}_s" do
      #     @formatter.format(base_in_timezone, chain_params.merge(:type => format_type.to_sym))
      #   end
      # end

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
          @formatter.format(base_in_timezone, options.merge(:type => :additional))
        else
          to_default_s
        end
      end

      def to_date
        LocalizedDate.new(@base_obj, @locale, chain_params)
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

        LocalizedTime.new(time, @locale, chain_params)
      end

      def with_timezone(timezone)
        self.class.new(@base_obj, @locale, chain_params.merge(:timezone => timezone))
      end

      protected

      def chain_params
        { :calendar_type => @calendar_type, :timezone => @timezone }
      end

      def base_in_timezone
        timezone_info.utc_to_local(@base_obj.new_offset(0))
      end

      def formatter_const
        TwitterCldr::Formatters::DateTimeFormatter
      end

      def timezone_info
        (@@timezone_info ||= {})[@timezone] ||= TZInfo::Timezone.get(@timezone)
      end
    end

  end
end