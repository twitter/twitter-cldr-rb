$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'twitter_cldr/version'

Gem::Specification.new do |s|
  s.name     = "twitter_cldr"
  s.version  = ::TwitterCldr::VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["cdutro@twitter.com"]
  s.homepage = "https://twitter.com"
  s.license  = "Apache-2.0"

  s.description = s.summary = "Ruby implementation of the ICU (International Components for Unicode) that uses the Common Locale Data Repository to format dates, plurals, and more."

  s.platform = Gem::Platform::RUBY
  s.summary  = "Ruby implementation of the ICU (International Components for Unicode) that uses the Common Locale Data Repository to format dates, plurals, and more."

  # json gem since v2.0 requries Ruby ~> 2.0
  s.add_dependency 'json', '~> 1.0' if RUBY_VERSION < '2'
  s.add_dependency 'camertron-eprun'
  s.add_dependency 'tzinfo'
  s.add_dependency 'cldr-plurals-runtime-rb', '~> 1.0'

  s.require_path = 'lib'

  gem_files       = Dir["{lib,spec,resources}/**/*", "Gemfile", "History.txt", "LICENSE", "NOTICE", "README.md", "Rakefile", "twitter_cldr.gemspec"]
  excluded_files  = %w[spec/collation/CollationTest_CLDR_NON_IGNORABLE.txt spec/normalization/NormalizationTest.txt]
  versioned_files = `git ls-files`.split("\n")

  s.files = (gem_files - excluded_files) & versioned_files
end
