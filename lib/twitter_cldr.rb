$:.push(File.dirname(__FILE__))
$:.push(File.dirname(File.dirname(__FILE__)))

require 'yaml'
require 'date'
require 'time'
require 'fileutils'

# gems
require 'mustache'
require 'json'

# patches for extending Ruby functionality
require 'ext/localized_object'
require 'ext/calendars/datetime'
require 'ext/calendars/date'
require 'ext/calendars/time'
require 'ext/numbers/localized_number'
require 'ext/numbers/bignum'
require 'ext/numbers/fixnum'
require 'ext/numbers/float'
require 'ext/strings/symbol'

# manages access to CLDR resources (yaml files in resources dir)
require 'shared/resources'

# renderers and compiler
require 'js/compiler'
require 'js/renderers/bundle'
require 'js/renderers/calendars/datetime_renderer'


module TwitterCldr
  DEFAULT_LOCALE = :en
  RESOURCE_DIR = File.join(File.dirname(File.dirname(File.expand_path(__FILE__))), "resources")

  # maps twitter locales to cldr locales
  TWITTER_LOCALE_MAP = { :msa     => :ms,
                         :'zh-cn' => :zh,
                         :'zh-tw' => :'zh-Hant' }

  @@resources = TwitterCldr::Shared::Resources.new

  def self.get_resource_file(locale, resource)
    File.join(RESOURCE_DIR, self.convert_locale(locale).to_s, "#{resource}.yml")
  end

  def self.resources
    @@resources
  end

  def self.get_locale
    defined?(FastGettext) ? FastGettext.locale.to_sym || DEFAULT_LOCALE : DEFAULT_LOCALE
  end

  def self.convert_locale(locale)
    locale = locale.to_sym
    TWITTER_LOCALE_MAP.include?(locale) ? TWITTER_LOCALE_MAP[locale] : locale
  end

  def self.all_locales
    unless defined?(@@all_locales)
      @@all_locales = Dir.glob(File.expand_path(File.join(File.dirname(__FILE__), "..", "resources", "*"))).map { |dir| File.basename(dir).to_sym }
      @@all_locales.delete(:shared)
    end
    @@all_locales
  end

  def self.supports?(locale)
    self.all_locales.include?(locale) || self.all_locales.include?(self.convert_locale(locale))
  end
end


# other shared libraries (most access shared resource data in resources/shared)
require 'shared/currencies'
require 'shared/languages'

# all tokenizers
require 'tokenizers/base'
require 'tokenizers/key_path'
require 'tokenizers/token'
require 'tokenizers/calendars/datetime_tokenizer'
require 'tokenizers/calendars/date_tokenizer'
require 'tokenizers/calendars/time_tokenizer'
require 'tokenizers/numbers/number_tokenizer'

# all formatters
require 'formatters/base'
require 'formatters/calendars/datetime_formatter'
require 'formatters/calendars/date_formatter'
require 'formatters/calendars/time_formatter'
require 'formatters/numbers/number_formatter'
require 'formatters/numbers/decimal_formatter'
require 'formatters/numbers/currency_formatter'
require 'formatters/numbers/percent_formatter'
require 'formatters/plurals/rules'

# formatter helpers
require 'formatters/numbers/helpers/base'
require 'formatters/numbers/helpers/fraction'
require 'formatters/numbers/helpers/integer'
