require File.join(File.dirname(__FILE__), "lib", "version")

Gem::Specification.new do |s|
  s.name = "twitter_cldr"
  s.version = ::TwitterCldr::VERSION
  s.authors = ["Cameron Dutro"]
  s.email = ["cdutro@twitter.com"]
  s.homepage = "http://twitter.com"
  s.description = s.summary = "Provides date, time, number, and list formatting functionality for various Twitter-supported locales in Ruby and Javascript."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.summary = "Text formatting using data from Unicode's Common Locale Data Repository (CLDR)."

  s.add_development_dependency 'rspec', '~> 2.9.0'
  s.add_development_dependency 'rr',    '~> 1.0.4'
  s.add_development_dependency 'rake',  '~> 0.8.7'
  s.add_development_dependency 'rcov' if RUBY_VERSION < '1.9.0'

  s.require_path = 'lib'
  s.files = %w(LICENSE README.md NOTICE Rakefile) + Dir.glob("{lib,spec,resources}/**/*")
end
