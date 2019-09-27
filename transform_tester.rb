require 'twitter_cldr'
require 'pry-nav'

k2l = TwitterCldr::Transforms::Transformer.get('Katakana-Latin')
l2k = TwitterCldr::Transforms::Transformer.get('Latin-Katakana')

puts l2k.transform(k2l.transform('クロネコサマ')) == 'クロネコサマ'
