source 'http://rubygems.org'

gemspec

# test and development dependencies that don't work with a particular version of MRI or JRuby

group :development do
  gem 'mustache', '~> 0.99.4'

  unless RUBY_PLATFORM == 'java'
    gem 'jasmine-headless-webkit', '~> 0.9.0.rc1'
    gem 'therubyracer', '~> 0.9.10'
    gem 'uglifier', '~> 1.2.4'
    gem 'coffee-script', '~> 2.2.0'

    if RUBY_VERSION < '1.9.0'
      gem 'rcov'
    end
  end

  gem 'nokogiri'
end

group :test do
  gem 'zip'
end