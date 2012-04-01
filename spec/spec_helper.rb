require File.expand_path(File.join(File.dirname(__FILE__), %w[.. lib twitter_cldr]))
FIXTURE_DIR = File.expand_path(File.join(File.dirname(__FILE__), %w[fixtures]))

class FastGettext
  class << self
    def locale
      @@locale || :en
    end

    def locale=(value)
      @@locale = value
    end
  end
end

Spec::Runner.configure do |config|
  config.mock_with :rr

  config.before(:each) do
    FastGettext.locale = :en
  end
end

def check_token_list(got, expected)
  got.size.should == expected.size
  expected.each_with_index do |exp_hash, index|
    exp_hash.each_pair do |exp_key, exp_val|
      got[index].send(exp_key).should == exp_val
    end
  end
end
