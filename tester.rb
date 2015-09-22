# encoding: UTF-8

require 'twitter_cldr'
require 'pry-nav'

# rule_group = TwitterCldr::Transforms::RuleGroup.load('Latin-Katakana')

# rule_group = TwitterCldr::Transforms::RuleGroup.load('Cyrillic-Latin')
# rule_set = rule_group.forward_rule_set
# puts rule_set.transform("Кэмерон Дутро")

# rule_set = rule_group.backward_rule_set
# puts rule_set.transform("Cameron Dutro")

short_string = "Cameron Dutro"
long_string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam tristique arcu ac elit pharetra, eget egestas neque bibendum. Duis consectetur sodales elit ut egestas. Ut sit amet est consequat, accumsan odio vitae, venenatis dui. Vivamus iaculis nulla nisl, eu blandit arcu ullamcorper non. Morbi lobortis quam enim, ac varius sem rhoncus non. Donec eget risus in arcu convallis sollicitudin eu imperdiet justo. Cras vulputate, lacus ut rhoncus suscipit, risus tellus sodales lectus, sit amet lobortis orci lorem eu felis. Sed mollis metus sed justo hendrerit, vel sollicitudin ipsum efficitur."

source_locale = TwitterCldr::Transforms::Locale.new('en', 'Latin', 'US')
target_locale = TwitterCldr::Transforms::Locale.new('ru', 'Cyrillic', 'RU')
transformer = TwitterCldr::Transforms::Transformer.find(source_locale, target_locale)
transformer.transform(long_string)
# puts transformer.transform(long_string)
# exit 0



# require 'ruby-prof'

# result = RubyProf.profile do
#   100.times do
#     transformer.transform(long_string)
#   end
# end

# printer = RubyProf::FlatPrinter.new(result)
# printer.print(STDOUT)
# exit 0



require 'benchmark/ips'

Benchmark.ips do |x|
  20.times do |i|
    char_len = 13 + (i * 5)
    x.report("#{char_len} chars long") do
      transformer.transform(long_string[0..char_len])
    end
  end

  x.compare!
end
