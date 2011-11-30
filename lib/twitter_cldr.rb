$:.push(File.dirname(__FILE__))

require 'yaml'
require 'active_support'

# require patches for extending Ruby functionality
require 'ext/date'
require 'ext/datetime'
require 'ext/fixnum'
require 'ext/float'

require 'core_ext/hash'

# manages access to CLDR resources (yaml files in resources dir)
require 'base/resource_manager'

# all tokenizers
require 'tokenizers/base'
require 'tokenizers/token'
require 'tokenizers/datetime_tokenizer'
require 'tokenizers/date_tokenizer'
require 'tokenizers/time_tokenizer'

# all compilers
require 'compilers/base'
require 'compilers/datetime_compiler'
require 'compilers/date_compiler'


module TwitterCldr
  DEFAULT_LOCALE = "en"
  RESOURCE_DIR = File.join(File.dirname(File.dirname(__FILE__)), "resources")
  @@resource_manager = ResourceManager.new

  def self.get_resource_file(locale, resource)
    File.join(RESOURCE_DIR, locale, "#{resource}.yml")
  end

  def self.resource_manager
    @@resource_manager
  end
end