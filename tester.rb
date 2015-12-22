require 'twitter_cldr'
require 'pry-nav'
require 'benchmark/ips'
require 'ruby-prof'

# rules = [
#   "$sep = \\-;",
#   "$Gi = ᄀ;",
#   "$Nf = ᆫ;",
#   "$latinMedialEnd = [aeiou];",
#   "$latinMedial = [aeiouwy];",
#   "$IEUNG = ᄋ;",
#   "$NG = ᆼ;",
#   "$jamoMedial = [ᅡ-ᅵ];",
#   "$sep < $latinMedialEnd n g {} $IEUNG $jamoMedial;"
# ]

# group = TwitterCldr::Transforms::RuleGroup.build(
#   rules, :bidirectional
# )

# cursor = TwitterCldr::Transforms::Cursor.new(TwitterCldr::Normalization.normalize("gimchang옥", using: :nfkd))
# cursor.advance(8)

# binding.pry
# group.rules.first.match(cursor)

transformer = TwitterCldr::Transforms::Transformer.get('Latin-Katakana')
puts transformer.transform("kuronekosama")


transformer = TwitterCldr::Transforms::Transformer.get('Serbian-Latin/BGN')
puts transformer.transform("На данашњи дан")


transformer = TwitterCldr::Transforms::Transformer.get('Oriya-Latin')
# expecting u'ikipiṛi'ā bẏabahāra karibē kipari
puts transformer.transform("ଉଇକିପିଡ଼ିଆ ବ୍ୟବହାର କରିବେ କିପରି")


transformer = TwitterCldr::Transforms::Transformer.get('Kannada-Latin')
puts transformer.transform("ಈ ತಿಂಗಳ ಪ್ರಮುಖ ದಿನಗಳು")


transformer = TwitterCldr::Transforms::Transformer.get('Gurmukhi-Latin')
puts transformer.transform("ਅੱਜ ਇਤਿਹਾਸ ਵਿੱਚ")


transformer = TwitterCldr::Transforms::Transformer.get('Gujarati-Latin')
puts transformer.transform("આ માસનો ઉમદા લેખ")


transformer = TwitterCldr::Transforms::Transformer.get('Bengali-Latin')
puts transformer.transform("নির্বাচিত নিবন্ধ")


transformer = TwitterCldr::Transforms::Transformer.get('Hangul-Latin')
puts transformer.transform("김창옥")

# two armenian transformers exist, the inverse of Latin-Armenian
# appears to be what ICU uses
transformer = TwitterCldr::Transforms::Transformer.get('Latin-Armenian').invert
puts transformer.transform("հեռախոսներ")  # expecting heṙaxosner

transformer = TwitterCldr::Transforms::Transformer.get('Arabic-Latin')
puts transformer.transform("مقالة اليوم المختارة")

# result = RubyProf.profile do
# puts(Benchmark.measure do
  transformer = TwitterCldr::Transforms::Transformer.get('Han-Latin')
  # binding.pry
  puts transformer.transform("因此只有两场风暴因造成")
  # binding.pry
# end)
# end

# puts(Benchmark.measure do
# result = RubyProf.profile do
# Benchmark.ips do |x|
#   x.report do
    # puts transformer.transform("因此只有两场风暴因造成")
#   end

#   x.compare!
# end
# end
# end)

# printer = RubyProf::FlatPrinter.new(result)
# printer.print(STDOUT, {})

transformer = TwitterCldr::Transforms::Transformer.get('Hiragana-Latin')
# Benchmark.ips do |x|
#   x.report do
    puts transformer.transform("くろねこさま")
  # end

  # x.compare!
# end

transformer = TwitterCldr::Transforms::Transformer.get('Greek-Latin')
# binding.pry
# Benchmark.ips do |x|
  # x.report do
    puts transformer.transform("Αλφαβητικός Κατάλογος")
  # end

#   x.compare!
# end
puts transformer.transform("διαφορετικούς")


transformer = TwitterCldr::Transforms::Transformer.get('Cyrillic-Latin')
puts transformer.transform('Влади́мир Влади́мирович Пу́тин')

# c = TwitterCldr::Transforms::Cursor.new("因此只有两场风暴因造成")
# c.advance(10)
# binding.pry
# puts transformer.rules[0].rule_index.get([0])[0].match(c)

# tokens = TwitterCldr::Shared::UnicodeRegex.send(:tokenizer).tokenize("[[[:Greek:][:Mn:][:Me:]][\\:-;?·;·]]")
# tokens = TwitterCldr::Shared::UnicodeRegex.send(:tokenizer).tokenize("[[a] [b]]")

# tokens.each do |token|
#   if token.type == :special_char
#     token.type = :string
#   end
# end

# tree = TwitterCldr::Shared::UnicodeRegex.send(:parser).parse(tokens)
# regex = TwitterCldr::Shared::UnicodeRegex.compile("[[[:Greek:][:Mn:][:Me:]][\\:-;?·;·]]")
# binding.pry
