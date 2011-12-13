$:.push(File.dirname(__FILE__))

require 'yaml'
require 'date'
require 'time'
require 'active_support'

# patches for extending Ruby functionality
require 'ext/hash'
require 'ext/localized_object'
require 'ext/calendars/datetime'
require 'ext/calendars/date'
require 'ext/calendars/time'
require 'ext/numbers/localized_number'
require 'ext/numbers/bignum'
require 'ext/numbers/fixnum'
require 'ext/numbers/float'

# manages access to CLDR resources (yaml files in resources dir)
require 'shared/resources'


module TwitterCldr
  DEFAULT_LOCALE = :en
  RESOURCE_DIR = File.join(File.dirname(File.dirname(__FILE__)), "resources")

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
    defined?(FastGettext) ? FastGettext.locale || DEFAULT_LOCALE : DEFAULT_LOCALE
  end

  def self.convert_locale(locale)
    TWITTER_LOCALE_MAP.include?(locale) ? TWITTER_LOCALE_MAP[locale] : locale
  end
end


# other shared libraries (most access shared resource data in resources/shared)
require 'shared/currencies'
#require 'shared/timezones'

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

# formatter helpers
require 'formatters/numbers/helpers/base'
require 'formatters/numbers/helpers/fraction'
require 'formatters/numbers/helpers/integer'
