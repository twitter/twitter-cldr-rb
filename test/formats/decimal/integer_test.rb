require File.dirname(__FILE__) + '/../../test_helper'

class TestCldrDecimalIntegerFormatWithInteger < Test::Unit::TestCase
  define_method "test: interpolates a number" do
    assert_equal '123', Cldr::Format::Decimal::Integer.new('###').apply(123)
  end
  
  define_method "test: interpolates a number on the right side" do
    assert_equal '0123', Cldr::Format::Decimal::Integer.new('0###').apply(123)
  end
  
  define_method "test: strips optional digits" do
    assert_equal '123', Cldr::Format::Decimal::Integer.new('######').apply(123)
  end
  
  define_method "test: single group" do
    assert_equal '1,23', Cldr::Format::Decimal::Integer.new('#,##').apply(123)
  end
  
  define_method "test: multiple groups with a primary group size" do
    assert_equal '1,23,45,67,89', Cldr::Format::Decimal::Integer.new('#,##').apply(123456789)
  end
  
  define_method "test: multiple groups with a primary and secondary group size" do
    assert_equal '12,34,56,789', Cldr::Format::Decimal::Integer.new('#,##,##0').apply(123456789)
  end
  
  define_method "test: does not group when no digits left of the grouping position" do
    assert_equal '123', Cldr::Format::Decimal::Integer.new('#,###').apply(123)
  end
  
  define_method "test: does not include a fraction for a float" do
    assert_equal '123', Cldr::Format::Decimal::Integer.new('###').apply(123.45)
  end
  
  define_method "test: does not round when given a float" do
    assert_equal '123', Cldr::Format::Decimal::Integer.new('###').apply(123.55)
  end
  
  define_method "test: does not round with :precision => 1" do
    assert_equal '123', Cldr::Format::Decimal::Integer.new('###').apply(123.55, :precision => 1)
  end
  
  define_method "test: ignores a fraction part given in the format string" do
    assert_equal '1,234', Cldr::Format::Decimal::Integer.new('#,##0.##').apply(1234.567)
  end
  
  define_method "test: cldr example #,##0.## => 1 234" do
    assert_equal '1,234', Cldr::Format::Decimal::Integer.new('#,##0.##').apply(1234.567)
  end
  
  define_method "test: cldr example #,##0.### => 1 234" do
    assert_equal '1 234', Cldr::Format::Decimal::Integer.new('#,##0.###', :group => ' ').apply(1234.567)
  end
  
  define_method "test: cldr example ###0.##### => 1234" do
    assert_equal '1234', Cldr::Format::Decimal::Integer.new('###0.#####', :group => ' ').apply(1234.567)
  end
  
  define_method "test: cldr example ###0.0000# => 1234" do
    assert_equal '1234', Cldr::Format::Decimal::Integer.new('###0.0000#', :group => ' ').apply(1234.567)
  end
  
  define_method "test: cldr example 00000.0000 => 01234" do
    assert_equal '01234', Cldr::Format::Decimal::Integer.new('00000.0000', :group => ' ').apply(1234.567)
  end
end