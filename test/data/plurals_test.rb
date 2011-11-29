require File.dirname(__FILE__) + '/../test_helper.rb'

class TestCldrDataPluralParser < Test::Unit::TestCase
  def cldr_data
    File.read(File.dirname(__FILE__) + '/../../vendor/cldr/common/supplemental/plurals.xml')
  end
  
  def cldr_rules
    Cldr::Data::Plurals::Rules.parse(cldr_data)
  end
  
  def test_compiles_to_valid_ruby_code
    assert_nothing_raised { eval(cldr_rules.to_ruby) }
  end
  
  def test_evals_to_a_hash_containing_plural_rule_and_keys_per_locale
    data = eval(cldr_rules.to_ruby)
    assert Hash === data
    assert Proc === data[:de][:i18n][:plural][:rule]
    assert_equal [:one, :other], data[:de][:i18n][:plural][:keys]
  end
  
  def test_lookup_rule_by_locale
    assert_equal "lambda { |n| n == 1 ? :one : :other }", cldr_rules.rule(:de).to_ruby
  end

  def test_parses_n
    assert Cldr::Data::Plurals::Rule.parse('n').is_a?(Cldr::Data::Plurals::Expression)
  end

  def test_parses_n_is_1
    rule = Cldr::Data::Plurals::Rule.parse('n is 1')
    assert_equal [:is, '1'], [rule.operator, rule.operand]
  end

  def test_parses_n_mod_1_is_1
    rule = Cldr::Data::Plurals::Rule.parse('n mod 1 is 1')
    assert_equal [:is, '1', '1'], [rule.operator, rule.operand, rule.mod]
  end

  def test_parses_n_is_not_1
    rule = Cldr::Data::Plurals::Rule.parse('n is not 1')
    assert_equal [:is, '1', true], [rule.operator, rule.operand, rule.negate]
  end

  def test_parses_n_mod_1_is_not_1
    rule = Cldr::Data::Plurals::Rule.parse('n mod 1 is not 1')
    assert_equal [:is, '1', true, '1'], [rule.operator, rule.operand, rule.negate, rule.mod]
  end

  def test_parses_n_in_1_2
    rule = Cldr::Data::Plurals::Rule.parse('n in 1..2')
    assert_equal [:in, '[1, 2]'], [rule.operator, rule.operand]
  end

  def test_parses_n_mod_1_in_1_2
    rule = Cldr::Data::Plurals::Rule.parse('n mod 1 in 1..2')
    assert_equal [:in, '[1, 2]', '1'], [rule.operator, rule.operand, rule.mod]
  end

  def test_parses_n_not_in_1_2
    rule = Cldr::Data::Plurals::Rule.parse('n not in 1..2')
    assert_equal [:in, '[1, 2]', true], [rule.operator, rule.operand, rule.negate]
  end

  def test_parses_n_mod_1_not_in_1_2
    rule = Cldr::Data::Plurals::Rule.parse('n mod 1 not in 1..2')
    assert_equal [:in, '[1, 2]', true, '1'], [rule.operator, rule.operand, rule.negate, rule.mod]
  end

  def test_parses_or_condition
    rule = Cldr::Data::Plurals::Rule.parse('n mod 1 is not 2 or n mod 2 in 3..4')
    assert_equal 2, rule.size
    assert_equal [:is, '2', true, '1'], [rule[0].operator, rule[0].operand, rule[0].negate, rule[0].mod]
    assert_equal [:in, '[3, 4]', false, '2'], [rule[1].operator, rule[1].operand, rule[1].negate, rule[1].mod]
  end

  def test_parses_and_condition
    rule = Cldr::Data::Plurals::Rule.parse('n mod 1 is not 2 and n mod 2 in 3..4')
    assert_equal 2, rule.size
    assert_equal [:is, '2', true, '1'], [rule[0].operator, rule[0].operand, rule[0].negate, rule[0].mod]
    assert_equal [:in, '[3, 4]', false, '2'], [rule[1].operator, rule[1].operand, rule[1].negate, rule[1].mod]
  end

  def test_compiles_n
    assert_equal 'n', Cldr::Data::Plurals::Rule.parse('n').to_ruby
  end

  def test_compiles_n_is_2
    assert_equal 'n == 2', Cldr::Data::Plurals::Rule.parse('n is 2').to_ruby
  end

  def test_compiles_n_mod_1_is_2
    assert_equal 'n % 1 == 2', Cldr::Data::Plurals::Rule.parse('n mod 1 is 2').to_ruby
  end

  def test_compiles_n_is_not_2
    assert_equal 'n != 2', Cldr::Data::Plurals::Rule.parse('n is not 2').to_ruby
  end

  def test_compiles_n_mod_1_is_not_2
    assert_equal 'n % 1 != 2', Cldr::Data::Plurals::Rule.parse('n mod 1 is not 2').to_ruby
  end

  def test_compiles_n_in_1_2
    assert_equal '[1, 2].include?(n)', Cldr::Data::Plurals::Rule.parse('n in 1..2').to_ruby
  end

  def test_compiles_n_mod_1_in_1_2
    assert_equal '[1, 2].include?(n % 1)', Cldr::Data::Plurals::Rule.parse('n mod 1 in 1..2').to_ruby
  end

  def test_compiles_n_not_in_1_2
    assert_equal '![1, 2].include?(n)', Cldr::Data::Plurals::Rule.parse('n not in 1..2').to_ruby
  end

  def test_compiles_n_mod_1_not_in_1_2
    assert_equal '![1, 2].include?(n % 1)', Cldr::Data::Plurals::Rule.parse('n mod 1 not in 1..2').to_ruby
  end

  def test_compiles_or_condition
    assert_equal 'n % 1 != 2 || [3, 4].include?(n % 2)', Cldr::Data::Plurals::Rule.parse('n mod 1 is not 2 or n mod 2 in 3..4').to_ruby
  end

  def test_compiles_and_condition
    assert_equal 'n % 1 != 2 && [3, 4].include?(n % 2)', Cldr::Data::Plurals::Rule.parse('n mod 1 is not 2 and n mod 2 in 3..4').to_ruby
  end

  def test_compiles_n_mod_100_in_3_99
    assert_equal '[3, 4, 5, 6].include?(n % 100)', Cldr::Data::Plurals::Rule.parse('n mod 100 in 3..6').to_ruby
  end
end