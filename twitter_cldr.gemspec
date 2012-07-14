require File.join(File.dirname(__FILE__), 'lib', 'twitter_cldr', 'version')

Gem::Specification.new do |s|
  s.name     = "twitter_cldr"
  s.version  = ::TwitterCldr::VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["cdutro@twitter.com"]
  s.homepage = "http://twitter.com"

  s.description = s.summary = "Provides date, time, number, and list formatting functionality for various Twitter-supported locales in Ruby and Javascript."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.summary  = "Text formatting using data from Unicode's Common Locale Data Repository (CLDR)."

  s.add_dependency 'json', '>= 1.1.9'

  s.require_path = 'lib'

  gem_files       = Dir["LICENSE", "README.md", "NOTICE", "Rakefile", "{lib,spec,resources}/**/*"]
  excluded_files  = %w[spec/collation/CollationTest_CLDR_NON_IGNORABLE.txt spec/normalization/NormalizationTest.txt]
  versioned_files = `git ls-files -z`.split("\0")

  s.files = (gem_files - excluded_files) & versioned_files
end
