source :rubygems

gemspec

group :development, :test do
  gem 'rake'
end

group :development do
  gem 'nokogiri'
  gem 'ruby-cldr', :github => 'tanin47/ruby-cldr', :ref => "aabe67a0da625b014bf4af72f41326cb586d0bd2"
end

group :test do
  gem 'rspec', '~> 2.11.0'
  gem 'rr',    '~> 1.0.4'
  gem 'zip'

  platform :mri_18 do
    gem 'rcov'
  end
end

