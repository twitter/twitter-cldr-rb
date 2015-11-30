require 'twitter_cldr'
require 'pry-nav'
require 'benchmark'
require 'ruby-prof'

# result = RubyProf.profile do
# puts(Benchmark.measure do
  transformer = TwitterCldr::Transforms::Transformer.get('Han', 'Spacedhan')
  # binding.pry
  # puts transformer.transform("因此只有两场风暴因造成")
  # binding.pry
# end)
# end

# puts(Benchmark.measure do
# result = RubyProf.profile do
  # puts transformer.transform("因此只有两场风暴因造成")
# end
# end)

# printer = RubyProf::FlatPrinter.new(result)
# printer.print(STDOUT, {})

# transformer = TwitterCldr::Transforms::Transformer.get('Hiragana', 'Latin')
# puts transformer.transform("くろねこさま")
# transformer = TwitterCldr::Transforms::Transformer.get('Greek', 'Latin')
# binding.pry
# puts transformer.transform("Αλφαβητικός Κατάλογος")
# puts transformer.transform("διαφορετικούς")

c = TwitterCldr::Transforms::Cursor.new("因此只有两场风暴因造成")
# c.advance(10)
# binding.pry
puts transformer.rules[0].rule_index.get([0])[0].match(c)

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
