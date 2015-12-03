require 'twitter_cldr'
require 'pry-nav'
require 'benchmark/ips'
require 'ruby-prof'

transformer = TwitterCldr::Transforms::Transformer.get('Hangul', 'Latin')
puts transformer.transform("김창옥")
exit 0

# transformer = TwitterCldr::Transforms::Transformer.get('Armenian', 'Latin')
# puts transformer.transform("հեռախոսներ")

# transformer = TwitterCldr::Transforms::Transformer.get('Arabic', 'Latin')
# puts transformer.transform("مقالة اليوم المختارة")

# result = RubyProf.profile do
# puts(Benchmark.measure do
  # transformer = TwitterCldr::Transforms::Transformer.get('Han', 'Latin')
  # binding.pry
  # puts transformer.transform("因此只有两场风暴因造成")
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

# transformer = TwitterCldr::Transforms::Transformer.get('Hiragana', 'Latin')
# Benchmark.ips do |x|
#   x.report do
    # puts transformer.transform("くろねこさま")
  # end

  # x.compare!
# end

# transformer = TwitterCldr::Transforms::Transformer.get('Greek', 'Latin')
# binding.pry
# Benchmark.ips do |x|
  # x.report do
    # puts transformer.transform("Αλφαβητικός Κατάλογος")
  # end

#   x.compare!
# end
# puts transformer.transform("διαφορετικούς")

# transformer = TwitterCldr::Transforms::Transformer.get('Cyrillic', 'Latin')
# puts transformer.transform('Влади́мир Влади́мирович Пу́тин')

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
