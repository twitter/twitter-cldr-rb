Gem::Specification.new do |s|
  s.name = "twitter_cldr"
  s.version = File.read("version.txt").chomp
  s.authors = ["Cameron Dutro"]
  s.email = ["cdutro@twitter.com"]
  s.homepage = "http://twitter.com"
  s.description = s.summary = "Provides date, time, number, and list formatting functionality for various Twitter-supported locales in Ruby and Javascript."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.summary = "Text formatting using data from Unicode's Common Locale Data Repository (CLDR)."

  s.require_path = 'lib'
  s.autorequire = ''
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{lib,spec}/**/*")
end
