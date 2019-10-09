require 'twitter_cldr'
require 'pry-nav'

rule_set = TwitterCldr::Segmentation::RuleSet.load(:en, 'word')
puts rule_set.each_boundary([0x0061, 0x1F1E6, 0x200D, 0x1F1E7, 0x1F1E8, 0x0062].pack('U*')).to_a.inspect
puts '÷ 0061 ÷ 1F1E6 × 200D × 1F1E7 ÷ 1F1E8 ÷ 0062 ÷'
puts '[0, 1, 4, 5, 6]'
