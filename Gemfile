source "https://rubygems.org"

gemspec

group :development, :test do
  gem 'rake'
  gem 'pry-nav'
  gem 'ruby-prof' unless RUBY_PLATFORM == 'java'
  gem 'regexp_parser', '~> 0.5'
  gem 'benchmark-ips'
  gem 'rubyzip', '~> 1.0'
end

group :development do
  gem 'nokogiri', "~> 1.0"
  gem 'parallel'

  gem 'ruby-cldr', github: 'svenfuchs/ruby-cldr'
  gem 'i18n'
  gem 'cldr-plurals', '~> 1.0'

  gem 'rest-client', '~> 1.8'
end

group :test do
  gem 'rspec', '~> 3.0'

  gem 'term-ansicolor', '~> 1.3'
  gem 'coveralls', require: false
  gem 'tins', '~> 1.6', require: false

  gem 'simplecov'
  gem 'launchy'
  gem 'addressable', '~> 2.4'
end
