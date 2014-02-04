# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'rbench'
require 'twitter_cldr'
require 'oniguruma'

RBench.run(10) do
  column :times
  column :one,  :title => "Run #1"
  column :two,  :title => "Run #2"

  group "Segmentation by sentence" do    
    str = "I really like Ms. Murphy. She's so, so cool! I wish she could come every day."

    report "with ULI rules" do

      iterator = TwitterCldr::Shared::BreakIterator.new(:en, {
        :use_uli_exceptions => true
      })

      # prime the pump
      iterator.each_sentence(str).to_a

      one { iterator.each_sentence(str).to_a }
      two { iterator.each_sentence(str).to_a }

    end

    report "without ULI rules" do

      iterator = TwitterCldr::Shared::BreakIterator.new(:en, {
        :use_uli_exceptions => false
      })

      # prime the pump
      iterator.each_sentence(str).to_a

      one { iterator.each_sentence(str).to_a }
      two { iterator.each_sentence(str).to_a }

    end

  end
end
