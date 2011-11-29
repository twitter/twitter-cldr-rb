$:.push(File.dirname(__FILE__))

# require all CLDR stuff
Dir.glob(File.join(File.dirname(__FILE__)), "cldr", "**", "**").each do |file|
  require file unless File.directory?(file)
end

# require patches for extending Ruby functionality
require 'ext/date'
require 'ext/datetime'
require 'ext/fixnum'
require 'ext/float'

# manages access to CLDR resources (yaml files in resources dir)
require 'manager/resource_manager'


module TwitterCldr
  @@resource_manager = ResourceManager.new
  RESOURCE_DIR = File.join(File.dirname(File.dirname(__FILE__)), "resources")

  def self.get_resource_file(locale, resource)
    File.join(RESOURCE_DIR, locale, "#{resource}.yml")
  end

  def self.resource_manager
    @@resource_manager
  end
end