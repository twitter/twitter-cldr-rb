# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

$:.push(File.dirname(__FILE__))

$KCODE = 'UTF-8' unless RUBY_VERSION >= '1.9.0'

require 'yaml'
require 'date'
require 'time'
require 'forwardable'

require 'twitter_cldr/version'

module TwitterCldr

  autoload :Formatters,  'twitter_cldr/formatters'
  autoload :Normalizers, 'twitter_cldr/normalizers'
  autoload :Shared,      'twitter_cldr/shared'
  autoload :Tokenizers,  'twitter_cldr/tokenizers'
  autoload :Utils,       'twitter_cldr/utils'

  extend SingleForwardable

  DEFAULT_LOCALE = :en
  DEFAULT_CALENDAR_TYPE = :gregorian

  RESOURCES_DIR = File.join(File.dirname(File.dirname(File.expand_path(__FILE__))), 'resources')
  NON_LOCALE_RESOURCES = [:shared, :unicode_data]

  # maps twitter locales to cldr locales
  TWITTER_LOCALE_MAP = {
      :msa     => :ms,
      :'zh-cn' => :zh,
      :'zh-tw' => :'zh-Hant'
  }

  def_delegator :resources, :resource_for, :get_resource

  class << self

    def get_resource_file(locale, resource)
      File.join(RESOURCES_DIR, convert_locale(locale).to_s, "#{resource}.yml")
    end

    def resources
      @resources ||= TwitterCldr::Shared::Resources.new
    end

    def get_locale
      if defined?(FastGettext)
        locale = FastGettext.locale
        locale = DEFAULT_LOCALE if locale.to_s.empty?
      else
        locale = DEFAULT_LOCALE
      end

      (supported_locale?(locale) ? locale : DEFAULT_LOCALE).to_sym
    end

    def convert_locale(locale)
      locale = locale.to_sym
      TWITTER_LOCALE_MAP.include?(locale) ? TWITTER_LOCALE_MAP[locale] : locale
    end

    def supported_locales
      @supported_locales ||= Dir.glob(File.join(RESOURCES_DIR, '*')).map { |f| File.basename(f).to_sym } - NON_LOCALE_RESOURCES
    end

    def supported_locale?(locale)
      locale = locale.to_sym
      supported_locales.include?(locale) || supported_locales.include?(convert_locale(locale))
    end

  end

end

require 'twitter_cldr/core_ext'