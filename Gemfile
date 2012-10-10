source :rubygems

gemspec

group :development, :test do
  gem 'rake'
end

group :development do
  gem 'nokogiri'
  gem 'ruby-cldr', :path => "/Users/cdutro/workspace/ruby-cldr"#:github => 'svenfuchs/ruby-cldr'
end

group :test do
  gem 'rspec', '~> 2.11.0'
  gem 'rr',    '~> 1.0.4'
  gem 'zip'

  platform :mri_18 do
    gem 'rcov'
  end
end

