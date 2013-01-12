# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    class Calendar

      DEFAULT_FORMAT = :'stand-alone'
      DEFAULT_PERIOD_FORMAT = :format

      NAMES_FORMS = [:wide, :narrow, :abbreviated]
      ERAS_NAMES_FORMS = [:abbr, :name]

      DATETIME_METHOD_MAP = {
        :year_of_week_of_year => :year,
        :quarter_stand_alone => :quarter,
        :month_stand_alone => :month,
        :day_of_month => :day,
        :day_of_week_in_month => :day,
        :weekday_local => :weekday,
        :weekday_local_stand_alone => :weekday,
        :second_fraction => :second,
        :timezone_generic_non_location => :timezone,
        :timezone_metazone => :timezone
      }

      REDIRECT_CONVERSIONS = {
        :dayPeriods => :periods
      }

      attr_reader :locale, :calendar_type

      def initialize(locale = TwitterCldr.locale, calendar_type = TwitterCldr::DEFAULT_CALENDAR_TYPE)
        @locale = TwitterCldr.convert_locale(locale)
        @calendar_type = calendar_type
      end

      def months(names_form = :wide, format = DEFAULT_FORMAT)
        data = get_with_names_form(:months, names_form, format)
        data && data.sort_by { |m| m.first }.map { |m| m.last }
      end

      def weekdays(names_form = :wide, format = DEFAULT_FORMAT)
        get_with_names_form(:days, names_form, format)
      end

      def fields
        get_data(:fields)
      end

      def quarters(names_form = :wide, format = DEFAULT_FORMAT)
        get_with_names_form(:quarters, names_form, format)
      end

      def periods(names_form = :wide, format = DEFAULT_PERIOD_FORMAT)
        get_with_names_form(:periods, names_form, format)
      end

      def eras(names_form = :name)
        get_data(:eras)[names_form]
      end

      def date_order(options = {})
        get_order_for(TwitterCldr::Tokenizers::DateTokenizer, options)
      end

      def time_order(options = {})
        get_order_for(TwitterCldr::Tokenizers::TimeTokenizer, options)
      end

      def datetime_order(options = {})
        get_order_for(TwitterCldr::Tokenizers::DateTimeTokenizer, options)
      end

      private

      def calendar_cache
        @@calendar_cache ||= {}
      end

      def get_order_for(const, options)
        opts = options.merge(:locale => @locale)
        cache_key = TwitterCldr::Utils.compute_cache_key([const.to_s] + opts.keys.sort + opts.values.sort)
        calendar_cache.fetch(cache_key) do |key|
          tokens = const.new(opts).tokens
          calendar_cache[cache_key] = resolve_methods(methods_for_tokens(tokens))
        end
      end

      def resolve_methods(methods)
        methods.map { |method| DATETIME_METHOD_MAP.fetch(method, method) }
      end

      def methods_for_tokens(tokens)
        tokens.inject([]) do |ret, token|
          if token.type == :pattern
            ret << TwitterCldr::Formatters::DateTimeFormatter::METHODS[token.value[0].chr]
          end
          ret
        end
      end

      def get_with_names_form(data_type, names_form, format)
        get_data(data_type, format, names_form) if NAMES_FORMS.include?(names_form.to_sym)
      end

      def get_data(*path)
        cache_key = TwitterCldr::Utils.compute_cache_key([@locale] + path)
        calendar_cache.fetch(cache_key) do |key|
          data = TwitterCldr::Utils.traverse_hash(calendar_data, path)
          redirect = parse_redirect(data)
          calendar_cache[key] = if redirect
            get_data(*redirect)
          else
            data
          end
        end
      end

      def parse_redirect(data)
        if data.is_a?(Symbol) && data.to_s =~ redirect_regexp
          result = $1.split('.').map(&:to_sym)
          result.map { |leg| REDIRECT_CONVERSIONS.fetch(leg, leg) }
        end
      end

      def redirect_regexp
        Regexp.new("^calendars\.#{calendar_type}\.(.*)$")
      end

      def calendar_data
        @calendar_data ||= TwitterCldr::Utils.traverse_hash(resource, [locale, :calendars, calendar_type])
      end

      def resource
        TwitterCldr.get_locale_resource(@locale, :calendars)
      end

    end
  end
end