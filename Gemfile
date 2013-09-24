source "https://rubygems.org"

gemspec

group :development, :test do
  gem 'rake'
  gem 'pry'
  gem 'pry-nav'
end

group :development do
  gem 'nokogiri', "~> 1.5.9"
  gem 'ruby-cldr', :github => 'camertron/ruby-cldr', :branch => 'rbnf'
  gem 'ruby2ruby', :github => 'camertron/ruby2ruby', :branch => 'not_equals'
end

group :test do
  gem 'rspec', '~> 2.11.0'
  gem 'rr',    '~> 1.0.4'
  gem 'zip'

  platform :mri_18 do
    gem 'rcov'
  end

  platform :mri_19 do
    gem 'simplecov'
    gem 'launchy'
  end
end
