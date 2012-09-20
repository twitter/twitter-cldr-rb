source :rubygems

gemspec

group :development, :test do
  gem 'rake'
end

group :development do
  gem 'nokogiri'
  gem 'ruby-cldr', :github => 'camertron/ruby-cldr', :branch => 'combined'
end

group :test do
  gem 'rspec', '~> 2.11.0'
  gem 'rr',    '~> 1.0.4'
  gem 'zip'

  platform :mri_18 do
    gem 'rcov'
  end
end

