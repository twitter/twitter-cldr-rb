source "https://rubygems.org"

gemspec

group :development, :test do
  gem 'rake'
  gem 'pry'
  gem 'pry-nav'
  gem 'rbench'

  if RUBY_VERSION >= "1.9" && RUBY_PLATFORM != "java"
    gem 'ruby-prof'
  end

  if RUBY_VERSION <= "1.8.7"
    gem 'oniguruma'
  end
end

group :development do
  gem 'nokogiri', "~> 1.5.9"

  # https://github.com/svenfuchs/ruby-cldr/pull/18
  # gem 'ruby-cldr', :github => 'svenfuchs/ruby-cldr'
  gem 'ruby-cldr', :github => 'camertron/ruby-cldr', :branch => "segmentation"
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

