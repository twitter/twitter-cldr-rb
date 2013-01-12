# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

$KCODE = 'UTF-8' unless RUBY_VERSION >= '1.9.0'

require 'yaml'
require 'date'
require 'time'
require 'fileutils'

# gems
require 'forwardable'

require 'twitter_cldr/version'

Enumerator = Enumerable::Enumerator unless defined?(Enumerator)

module TwitterCldr

  autoload :Formatters,    'twitter_cldr/formatters'
  autoload :Collation,     'twitter_cldr/collation'
  autoload :Localized,     'twitter_cldr/localized'
  autoload :Normalization, 'twitter_cldr/normalization'
  autoload :Resources,     'twitter_cldr/resources'
  autoload :Shared,        'twitter_cldr/shared'
  autoload :Tokenizers,    'twitter_cldr/tokenizers'
  autoload :Utils,         'twitter_cldr/utils'

  extend SingleForwardable

  # version of CLDR that was used for generating YAML files in the resources/ directory
  CLDR_VERSION = '21.0' # release date: 2012-02-10

  DEFAULT_LOCALE = :en
  DEFAULT_CALENDAR_TYPE = :gregorian

  RESOURCES_DIR = File.join(File.dirname(File.dirname(File.expand_path(__FILE__))), 'resources')

  # maps twitter locales to cldr locales
  TWITTER_LOCALE_MAP = {
      :msa     => :ms,
      :'zh-cn' => :zh,
      :'zh-tw' => :'zh-Hant',
      :no      => :nb
  }

  # maps cldr locales to twitter locales
  CLDR_LOCALE_MAP = TWITTER_LOCALE_MAP.invert

  def_delegator :resources, :get_resource
  def_delegator :resources, :get_locale_resource

  class << self

    attr_writer :locale

    def resources
      @resources ||= TwitterCldr::Resources::Loader.new
    end

    def locale
      locale = supported_locale?(@locale) ? @locale : find_fallback
      locale = DEFAULT_LOCALE if locale.to_s.empty?
      (supported_locale?(locale) ? locale : DEFAULT_LOCALE).to_sym
    end

    def with_locale(locale)
      raise "Unsupported locale" unless supported_locale?(locale)

      begin
        old_locale = @locale
        @locale = locale
        result = yield
      ensure
        @locale = old_locale
        result
      end
    end

    def register_locale_fallback(proc_or_locale)
      case proc_or_locale
        when Symbol, String, Proc
          locale_fallbacks << proc_or_locale
        else
          raise "A locale fallback must be of type String, Symbol, or Proc."
      end
      nil
    end

    def reset_locale_fallbacks
      locale_fallbacks.clear
      TwitterCldr.register_locale_fallback(lambda { I18n.locale if defined?(I18n) && I18n.respond_to?(:locale) })
      TwitterCldr.register_locale_fallback(lambda { FastGettext.locale if defined?(FastGettext) && FastGettext.respond_to?(:locale) })
    end

    def locale_fallbacks
      @locale_fallbacks ||= []
    end

    def convert_locale(locale)
      locale = locale.to_sym if locale.respond_to?(:to_sym)
      TWITTER_LOCALE_MAP.fetch(locale, locale)
    end

    def twitter_locale(locale)
      locale = locale.to_sym
      CLDR_LOCALE_MAP.fetch(locale, locale)
    end

    def supported_locales
      @supported_locales ||= Dir.glob(File.join(RESOURCES_DIR, 'locales', '*')).map { |f| File.basename(f).to_sym }
    end

    def supported_locale?(locale)
      !!locale && supported_locales.include?(convert_locale(locale))
    end

    protected

    def find_fallback
      locale_fallbacks.reverse_each do |fallback|
        result = if fallback.is_a?(Proc)
          begin
            fallback.call
          rescue
            nil
          end
        else
          fallback
        end
        return result if result
      end
      nil
    end

  end

end

TwitterCldr.reset_locale_fallbacks

require 'twitter_cldr/core_ext'
