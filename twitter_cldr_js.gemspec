$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'twitter_cldr/js/version'

Gem::Specification.new do |s|
  s.name     = "twitter_cldr_js"
  s.version  = ::TwitterCldr::Js::VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["cdutro@twitter.com"]
  s.homepage = "http://twitter.com"

  s.description = s.summary = "Provides date, time, number, and list formatting functionality for various Twitter-supported locales in Javascript."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.summary  = "Text formatting using data from Unicode's Common Locale Data Repository (CLDR)."

  s.add_dependency 'json', '>= 1.1.9'
  # s.add_dependency 'twitter_cldr', '>= 2.0.0'
  s.add_dependency 'railties', '~> 3.1'
  s.add_dependency 'rake', '~> 0.9.2.2'
  s.add_dependency 'mustache', '~> 0.99.4'
  s.add_dependency 'ruby_parser', '~> 2.3.1'
  s.add_dependency 'therubyracer',  '~> 0.9.10'
  s.add_dependency 'uglifier',      '~> 1.2.4'
  s.add_dependency 'coffee-script', '~> 2.2.0'

  s.require_path = 'lib'

  gem_files       = Dir["{lib,spec}/**/*", "Gemfile", "History.txt", "LICENSE", "NOTICE", "README.md", "Rakefile", "twitter_cldr_js.gemspec"]
  excluded_files  = %w[]
  versioned_files = `git ls-files`.split("\n")

  s.files = (gem_files - excluded_files) & versioned_files
end
