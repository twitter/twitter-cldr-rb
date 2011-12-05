$:.push(File.dirname(__FILE__))

require 'yaml'
require 'active_support'

# require patches for extending Ruby functionality
require 'ext/datetime'
require 'ext/date'
require 'ext/time'
require 'ext/fixnum'
require 'ext/float'
require 'ext/hash'

# manages access to CLDR resources (yaml files in resources dir)
require 'base/resource_manager'

# all tokenizers
require 'tokenizers/base'
require 'tokenizers/token'
require 'tokenizers/datetime_tokenizer'
require 'tokenizers/date_tokenizer'
require 'tokenizers/time_tokenizer'

# all compilers
require 'formatters/base'
require 'formatters/datetime_formatter'


module TwitterCldr
  DEFAULT_LOCALE = "en"
  RESOURCE_DIR = File.join(File.dirname(File.dirname(__FILE__)), "resources")
  @@resource_manager = ResourceManager.new

  def self.get_resource_file(locale, resource)
    File.join(RESOURCE_DIR, locale.to_s, "#{resource}.yml")
  end

  def self.resource_manager
    @@resource_manager
  end

  def self.get_locale
    defined?(FastGettext) ? FastGettext.locale || DEFAULT_LOCALE : DEFAULT_LOCALE
  end
end