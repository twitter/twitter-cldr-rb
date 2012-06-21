# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

$:.push(File.dirname(__FILE__))
$:.push(File.dirname(File.dirname(__FILE__)))

$KCODE = 'UTF-8' unless RUBY_VERSION >= '1.9.0'

require 'yaml'
require 'date'
require 'time'
require 'fileutils'

# gems
require 'forwardable'

require 'twitter_cldr/version'

module TwitterCldr

  autoload :Formatters,    'twitter_cldr/formatters'
  autoload :Collation,     'twitter_cldr/collation'
  autoload :Normalization, 'twitter_cldr/normalization'
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
      return false unless locale
      locale = locale.to_sym
      supported_locales.include?(locale) || supported_locales.include?(convert_locale(locale))
    end

    def require_js
      require "js/lib/twitter_cldr_js"
    end
  end

end

require 'twitter_cldr/core_ext'
