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
  gem 'nokogiri', "~> 1.5.9"

  gem 'ruby-cldr', github: 'svenfuchs/ruby-cldr'
  gem 'i18n', '~> 0.6.11'
  gem 'cldr-plurals', '~> 1.0'

  gem 'rest-client', '~> 1.8'
end

group :test do
  gem 'rspec', '~> 3.0'

  gem 'term-ansicolor', '~> 1.3.0'        # 1.4 breaks ruby 1.9 support
  gem 'coveralls', require: false
  gem 'tins', '~> 1.6.0', require: false  # 1.7 breaks ruby 1.9 support

  gem 'simplecov'
  gem 'launchy'
  gem 'addressable', '~> 2.4.0'           # 2.5 breaks ruby 1.9 support
end
