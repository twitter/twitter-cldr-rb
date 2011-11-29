# encoding: utf-8

require File.dirname(__FILE__) + '/../test_helper.rb'

class TestCldrDataNumbers < Test::Unit::TestCase
  define_method "test: number symbols :de" do
    expected = {
      :nan               => "NaN",
      :decimal           => ",",
      :plus_sign         => "+",
      :minus_sign        => "-",
      :group             => ".",
      :exponential       => "E",
      :percent_sign      => "%",
      :list              => ";",
      :per_mille         => "‰",
      :native_zero_digit => "0",
      :infinity          => "∞",
      :pattern_digit     => "#"
    }
    assert_equal expected, Cldr::Data::Numbers.new('de')[:numbers][:symbols]
  end

  define_method "test: number formats :de" do
    expected = {
      :decimal => {
        :patterns => {
          :default => "#,##0.###"
        }
      },
      :scientific => {
        :patterns => {
          :default => "#E0"
        }
      },
      :percent => {
        :patterns => {
          :default => "#,##0 %"     # includes a non-breaking space (\302\240)
        }
      },
      :currency => {
        :patterns => {
          :default => "#,##0.00 ¤", # includes a non-breaking space (\302\240)
        },
        :unit => {
          "one"   => "{0} {1}",
          "other" => "{0} {1}"
        }
      }
    }
    assert_equal expected, Cldr::Data::Numbers.new('de')[:numbers][:formats]
  end

  # Cldr::Data.locales.each do |locale|
  #   define_method "test: extract number_symbols for #{locale}" do
  #     assert_nothing_raised do
  #       Cldr::Data::Numbers.new(locale)
  #     end
  #   end
  # end
end