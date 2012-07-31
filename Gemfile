source 'http://rubygems.org'

gemspec

group :development, :test do
  gem 'rake'
end

group :development do
  gem 'mustache', '~> 0.99.4'
  gem 'nokogiri'
  gem 'ruby_parser', '~> 2.3.1'

  gem 'ruby-cldr', :github => 'KL-7/ruby-cldr', :branch => 'for-twitter-cldr'

  platform :ruby do
    gem 'therubyracer',  '~> 0.9.10'
    gem 'uglifier',      '~> 1.2.4'
    gem 'coffee-script', '~> 2.2.0'
  end
end

group :test do
  gem 'rspec', '~> 2.11.0'
  gem 'rr',    '~> 1.0.4'
  gem 'zip'

  platform :ruby do
    gem 'jasmine-headless-webkit', '~> 0.9.0.rc1'
  end

  platform :mri_18 do
    gem 'rcov'
  end
end