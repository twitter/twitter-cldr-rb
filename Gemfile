source "https://rubygems.org"

gemspec

group :development, :test do
  gem 'rake'
  gem 'pry'
  gem 'pry-nav'

  if RUBY_VERSION >= "1.9" && RUBY_PLATFORM != "java"
    gem 'ruby-prof'
  end
end

group :development do
  gem 'nokogiri', "~> 1.5.9"

  # https://github.com/svenfuchs/ruby-cldr/pull/18
  # gem 'ruby-cldr', :github => 'svenfuchs/ruby-cldr'
  # gem 'ruby-cldr', :github => 'camertron/ruby-cldr', :branch => "numbering_systems"
  gem 'ruby-cldr', :path => "~/workspace/ruby-cldr"

  # https://github.com/seattlerb/ruby2ruby/pull/24
  # gem 'ruby2ruby', :github => 'camertron/ruby2ruby', :branch => 'not_equals'
end

group :test do
  gem 'rspec', '~> 2.11.0'
  gem 'rr',    '~> 1.0.4'

  if RUBY_VERSION >= "1.9"
    gem 'rubyzip'
  end

  platform :mri_18 do
    gem 'rcov'
  end

  platform :mri_19 do
    gem 'simplecov'
    gem 'launchy'
  end
end

