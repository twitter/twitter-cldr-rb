require File.expand_path(File.join(File.dirname(__FILE__), %w[.. lib twitter_cldr]))
FIXTURE_DIR = File.expand_path(File.join(File.dirname(__FILE__), %w[fixtures]))

Spec::Runner.configure do |config|
  config.mock_with :rr
end