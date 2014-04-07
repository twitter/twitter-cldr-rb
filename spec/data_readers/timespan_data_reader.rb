    it "should read correct tokens from custom locale" do
      tokenizer = TimespanTokenizer.new(:locale => :sv)
      one_day_ago = tokenizer.tokens(:unit => :day, :direction => :ago, :number => 1, :type => :default)
      one_day_ago[0].should == { :value => "för ", :type => :plaintext }
      one_day_ago[1].should == { :value => "{0}", :type => :placeholder }
      one_day_ago[2].should == { :value => " dag sedan", :type => :plaintext }

      two_days_ago = tokenizer.tokens(:unit => :day, :direction => :ago, :number => 2, :type => :default)
      two_days_ago[0].should == { :value => "för ", :type => :plaintext }
      two_days_ago[1].should == { :value => "{0}", :type => :placeholder }
      two_days_ago[2].should == { :value => " dagar sedan", :type => :plaintext }

      one_day_until = tokenizer.tokens(:unit => :day, :direction => :until, :number => 1, :type => :default)
      one_day_until[0].should == { :value => "om ", :type => :plaintext }
      one_day_until[1].should == { :value => "{0}", :type => :placeholder }
      one_day_until[2].should == { :value => " dag", :type => :plaintext }

      two_days_until = tokenizer.tokens(:unit => :day, :direction => :until, :number => 2, :type => :default)
      two_days_until[0].should == { :value => "om ", :type => :plaintext }
      two_days_until[1].should == { :value => "{0}", :type => :placeholder }
      two_days_until[2].should == { :value => " dagar", :type => :plaintext }
    end