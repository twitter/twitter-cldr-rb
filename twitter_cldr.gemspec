require File.join(File.dirname(__FILE__), 'lib', 'twitter_cldr', 'version')

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

  s.add_dependency 'json', '>= 1.1.9'

  s.add_development_dependency 'mustache', '~> 0.99.4'
  s.add_development_dependency 'rspec', '~> 2.9.0'
  s.add_development_dependency 'rr', '~> 1.0.4'
  s.add_development_dependency 'rake', '~> 0.9.2'
  s.add_development_dependency 'jasmine-headless-webkit', '~> 0.9.0.rc1'
  s.add_development_dependency 'therubyracer', '~> 0.9.10'
  s.add_development_dependency 'uglifier', '~> 1.2.4'
  s.add_development_dependency 'coffee-script', '~> 2.2.0'
  s.add_development_dependency 'rcov' if RUBY_VERSION < '1.9.0'
  s.add_development_dependency 'zip'

  s.require_path = 'lib'
  s.files = %w(LICENSE README.md NOTICE Rakefile) + Dir.glob("{lib,spec,resources}/**/*")
end
