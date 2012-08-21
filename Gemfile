source :rubygems

gemspec

group :development, :test do
  gem 'rake'
end

group :development do
  gem 'mustache', '~> 0.99.4'
  gem 'ruby_parser', '~> 2.3.1'

  platform :ruby do
    gem 'therubyracer',  '~> 0.9.10'
    gem 'uglifier',      '~> 1.2.4'
    gem 'coffee-script', '~> 2.2.0'
  end
end

group :test do
  gem 'rspec', '~> 2.11.0'
  gem 'rr',    '~> 1.0.4'

  platform :mri_18 do
    gem 'rcov'
  end
end