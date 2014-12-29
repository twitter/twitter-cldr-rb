source "https://rubygems.org"

gemspec

group :development, :test do
  gem 'rake'

  gem 'pry'
  gem 'pry-nav'

  platform :rbx do
    gem 'rubinius-debugger'
  end

  if RUBY_VERSION >= "1.9" && RUBY_PLATFORM != "java" && RUBY_ENGINE != "rbx"
    gem 'ruby-prof'
  end

  if RUBY_VERSION <= "1.8.7"
    gem 'oniguruma'
  end

  gem 'regexp_parser', '~> 0.1.6'
end

group :development do
  gem 'nokogiri', "~> 1.5.9"

  gem 'ruby-cldr', :github => 'kl-7/ruby-cldr', :branch => 'kl_nubmber_patttern_pluralization'
  gem 'cldr-plurals', '~> 1.0.0'
end

group :test do
  gem 'rspec', '~> 2.14.0'
  gem 'rr',    '~> 1.1.2'

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

