# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

def spaces(str)
  str.gsub("\xC2\xA0", " ")
end

describe "README" do
  it "verifies supported_locales" do
    sup = TwitterCldr.supported_locales
    sup.should be_a(Array)
    sup.first.should be_a(Symbol)
  end

  it "verifies supported_locale?" do
    TwitterCldr.supported_locale?(:es).should be_true
    TwitterCldr.supported_locale?(:xx).should be_false
  end

  it "verifies number formatting" do
    nbsp = "\xC2\xA0"
    1337.localize(:es).to_s.should == "1.337"
    spaces(1337.localize(:es).to_currency.to_s).should == "1.337,00 $"
    spaces(1337.localize(:es).to_currency.to_s(:currency => "EUR").to_s).should == "1.337,00 €"
    1337.localize(:es).to_percent.to_s.should == "1.337%"
    1337.localize(:es).to_percent.to_s(:precision => 2).should == "1.337,00%"
    1337.localize(:es).to_decimal.to_s(:precision => 3).should == "1.337,000"

    num = TwitterCldr::Localized::LocalizedNumber.new(1337, :es)
    spaces(num.to_currency.to_s).should == "1.337,00 $"
  end

  it "verifies extra currency data" do
    currency_codes = TwitterCldr::Shared::Currencies.currency_codes
    currency_codes.should be_a(Array)
    currency_codes.should include("LTL")
    currency_codes.should include("PHP")
    TwitterCldr::Shared::Currencies.for_code("CAD").should == {
      :currency => :CAD,
      :cldr_symbol => "CA$",
      :symbol => "$",
      :name => "Canadian dollar",
      :code_points => [36]
    }
  end

  it "verifies short and long decimals" do
    2337.localize.to_short_decimal.to_s.should == "2K"
    1337123.localize.to_short_decimal.to_s.should == "1M"

    2337.localize.to_long_decimal.to_s.should == "2 thousand"
    1337123.localize.to_long_decimal.to_s.should == "1 million"
  end

  it "verifies dates" do
    date_time = DateTime.new(2011, 12, 12, 21, 44, 57, -8.0 / 24.0)
    date = date_time.localize.to_date.base_obj
    time = Time.at(date_time.localize.to_time.base_obj.utc - (8 * 60 * 60))

    date_time.localize(:es).to_full_s.should == "lunes, 12 de diciembre de 2011 21:44:57 UTC -0800"
    date_time.localize(:es).to_long_s.should == "12 de diciembre de 2011 21:44:57 -08:00"
    date_time.localize(:es).to_medium_s.should == "12/12/2011 21:44:57"
    date_time.localize(:es).to_short_s.should == "12/12/11 21:44"

    date.localize(:es).to_full_s.should == "lunes, 12 de diciembre de 2011"
    date.localize(:es).to_long_s.should == "12 de diciembre de 2011"
    date.localize(:es).to_medium_s.should == "12/12/2011"
    date.localize(:es).to_short_s.should == "12/12/11"

    time.localize(:es).to_full_s.should match(/21:44:57 UTC [-+]\d{4}/)
    time.localize(:es).to_long_s.should == "21:44:57 UTC"
    time.localize(:es).to_medium_s.should == "21:44:57"
    time.localize(:es).to_short_s.should == "21:44"

    dt = TwitterCldr::Localized::LocalizedDateTime.new(date_time, :es)
    dt.to_short_s.should == "12/12/11 21:44"
  end

  it "verifies additional date formats" do
    date_time = DateTime.new(2011, 12, 12, 21, 44, 57, -8.0 / 24.0)
    TwitterCldr::Formatters::DateTimeFormatter.additional_formats_for(:ja).should be_a(Array)
    date_time.localize(:ja).to_s.should == "2011/12/12 21:44:57"
    date_time.localize(:ja).to_s(:format => "EEEEd").should == "12日月曜日"
  end

  it "verifies relative time spans" do
    (DateTime.now - 1).localize.ago.to_s.should match_normalized("1 day ago")
    (DateTime.now - 0.5).localize.ago.to_s.should match_normalized("12 hours ago")  # (i.e. half a day)

    (DateTime.now + 1).localize.until.to_s.should match_normalized("In 1 day")
    (DateTime.now + 0.5).localize.until.to_s.should match_normalized("In 12 hours")

    (DateTime.now - 1).localize(:de).ago.to_s.should match_normalized("Vor 1 Tag")
    (DateTime.now + 1).localize(:de).until.to_s.should match_normalized("In 1 Tag")

    (DateTime.now - 1).localize(:de).ago.to_s(:unit => :hour).should match_normalized("Vor 24 Stunden")
    (DateTime.now + 1).localize(:de).until.to_s(:unit => :hour).should match_normalized("In 24 Stunden")

    # 86400 = 1 day in seconds, 259200 = 3 days in seconds
    (Time.now + 86400).localize(:de).ago(:base_time => (Time.now + 259200)).to_s(:unit => :hour).should match_normalized("Vor 48 Stunden")

    ts = TwitterCldr::Localized::LocalizedTimespan.new(86400, :locale => :de)
    ts.to_s.should match_normalized("In 1 Tag")
    ts.to_s(:unit => :hour).should match_normalized("In 24 Stunden")

    ts = TwitterCldr::Localized::LocalizedTimespan.new(-86400, :locale => :de)
    ts.to_s.should match_normalized("Vor 1 Tag")
    ts.to_s(:unit => :hour).should match_normalized("Vor 24 Stunden")
  end

  it "verifies approximate timespans" do
    TwitterCldr::Localized::LocalizedTimespan.new(44).to_s(:approximate => true).should == "In 44 seconds"
    TwitterCldr::Localized::LocalizedTimespan.new(45).to_s(:approximate => true).should == "In 1 minute"
    TwitterCldr::Localized::LocalizedTimespan.new(52).to_s(:approximate => true).should == "In 1 minute"
  end

  it "verifies plural rules" do
    1.localize(:ru).plural_rule.should == :one
    2.localize(:ru).plural_rule.should == :few
    5.localize(:ru).plural_rule.should == :many

    TwitterCldr::Formatters::Plurals::Rules.all.should == [:one, :other]
    TwitterCldr::Formatters::Plurals::Rules.all_for(:es).should == [:one, :other]
    TwitterCldr::Formatters::Plurals::Rules.all_for(:ru).should == [:one, :few, :many, :other]

    # get the rule for a number in a specific locale
    TwitterCldr::Formatters::Plurals::Rules.rule_for(1, :ru).should == :one
    TwitterCldr::Formatters::Plurals::Rules.rule_for(2, :ru).should == :few
  end

  describe "plural interpolation" do
    it "verifies first technique" do
      replacements = { :horse_count => 3,
                       :horses => { :one => "is 1 horse",
                                    :other => "are %{horse_count} horses" } }

      ("there %{horse_count:horses} in the barn".localize % replacements).should == "there are 3 horses in the barn"
    end

    it "verifies second technique" do
      str = 'there %<{ "horse_count": { "one": "is one horse", "other": "are %{horse_count} horses" } }> in the barn'
      (str.localize % { :horse_count => 3 }).should == "there are 3 horses in the barn"
    end

    it "verifies regular Ruby interpolation works" do
      ("five euros plus %.3f in tax" % (13.25 * 0.087)).should == "five euros plus 1.153 in tax"

      if RUBY_VERSION >= '1.9.0'
        ("there are %{count} horses in the barn" % { :count => "5" }).should == "there are 5 horses in the barn"
      end
    end

    it "verifies named interpolation parameters" do
      #"five euros plus %<percent>.3f in %{noun}".localize % { :percent => 13.25 * 0.087, :noun => "tax" }.should == "five euros plus 1.15 in tax"
    end
  end

  it "verifies language code conversion" do
    TwitterCldr::Shared::LanguageCodes.convert(:es, :from => :bcp_47, :to => :iso_639_2).should == :spa

    expected = [:bcp_47, :iso_639_1, :iso_639_2, :iso_639_3]
    actual = TwitterCldr::Shared::LanguageCodes.standards_for(:es, :bcp_47)
    expected.size.should == actual.size
    actual.each { |standard| expected.should include(standard) }

    expected = [:bcp_47, :iso_639_1, :iso_639_2, :iso_639_3]
    actual = TwitterCldr::Shared::LanguageCodes.standards_for_language(:Spanish)
    expected.size.should == actual.size
    actual.each { |standard| expected.should include(standard) }

    TwitterCldr::Shared::LanguageCodes.languages.should include(:Spanish)

    TwitterCldr::Shared::LanguageCodes.valid_standard?(:iso_639_1).should be_true
    TwitterCldr::Shared::LanguageCodes.valid_standard?(:blarg).should be_false

    TwitterCldr::Shared::LanguageCodes.valid_code?(:es, :bcp_47).should be_true
    TwitterCldr::Shared::LanguageCodes.valid_code?(:es, :iso_639_2).should be_false

    TwitterCldr::Shared::LanguageCodes.from_language(:Spanish, :iso_639_2).should == :spa

    TwitterCldr::Shared::LanguageCodes.to_language(:spa, :iso_639_2).should == "Spanish"
  end

  it "verifies postal code validations" do
    TwitterCldr::Shared::PostalCodes.valid?(:us, "94103").should be_true
    TwitterCldr::Shared::PostalCodes.valid?(:us, "9410").should be_false
    TwitterCldr::Shared::PostalCodes.valid?(:gb, "BS98 1TL").should be_true
    TwitterCldr::Shared::PostalCodes.valid?(:se, "280 12").should be_true
    TwitterCldr::Shared::PostalCodes.valid?(:ca, "V3H 1Z7").should be_true

    TwitterCldr::Shared::PostalCodes.territories.should include(:gb)

    TwitterCldr::Shared::PostalCodes.regex_for_territory(:us).should == /\d{5}([ \-]\d{4})?/
  end

  it "verifies phone codes" do
    TwitterCldr::Shared::PhoneCodes.code_for_territory(:us).should == "1"
    TwitterCldr::Shared::PhoneCodes.code_for_territory(:pe).should == "51"
    TwitterCldr::Shared::PhoneCodes.code_for_territory(:eg).should == "20"
    TwitterCldr::Shared::PhoneCodes.code_for_territory(:dk).should == "45"
    TwitterCldr::Shared::PhoneCodes.territories.should include(:pe)
  end

  it "verifies world languages" do
    :es.localize(:es).as_language_code.should == "español"
    :ru.localize(:es).as_language_code.should == "ruso"
    ls = TwitterCldr::Localized::LocalizedSymbol.new(:ru, :es)
    ls.as_language_code.should == "ruso"
  end

  it "verifies language data" do
    # get all languages for the default locale
    all = TwitterCldr::Shared::Languages.all
    all.should include(:"zh-Hant")
    all[:'zh-Hant'].should == "Traditional Chinese"
    all.should include(:vi)
    all[:vi].should == "Vietnamese"

    # get all languages for a specific locale
    all_es = TwitterCldr::Shared::Languages.all_for(:es)
    all_es.should include(:"zh-Hant")
    all_es[:'zh-Hant'].should == "chino tradicional"
    all_es.should include(:vi)
    all_es[:vi].should == "vietnamita"

    # get a language by its code for the default locale
    TwitterCldr::Shared::Languages.from_code(:'zh-Hant').should == "Traditional Chinese"

    # get a language from its code for a specific locale
    TwitterCldr::Shared::Languages.from_code_for_locale(:'zh-Hant', :es).should == "chino tradicional"

    # translate a language from one locale to another
    TwitterCldr::Shared::Languages.translate_language("chino tradicional", :es, :en).should == "Traditional Chinese"
    TwitterCldr::Shared::Languages.translate_language("Traditional Chinese", :en, :es).should == "chino tradicional"
  end

  it "verifies code point conversions" do
    code_point = TwitterCldr::Shared::CodePoint.find(0x1F3E9)
    code_point.name.should             == "LOVE HOTEL"
    code_point.bidi_mirrored.should    == "N"
    code_point.category.should         == "So"
    code_point.combining_class.should  == "0"

    # Convert characters to code points:
    TwitterCldr::Utils::CodePoints.from_string("¿").should == [0x0BF]

    # Convert code points to characters:
    TwitterCldr::Utils::CodePoints.to_string([0xBF]).should == "¿"
  end

  it "verifies normalization" do
    TwitterCldr::Normalization::NFD.normalize('français').should == TwitterCldr::Utils::CodePoints.to_string([0x66, 0x72, 0x61, 0x6E, 0x63, 0x327, 0x61, 0x69, 0x73])
    TwitterCldr::Utils::CodePoints.from_string('español').should == [0x65, 0x73, 0x70, 0x61, 0xF1, 0x6F, 0x6C]
    TwitterCldr::Utils::CodePoints.from_string(TwitterCldr::Normalization::NFD.normalize('español')).should == [0x65, 0x73, 0x70, 0x61, 0x6E, 0x303, 0x6F, 0x6C]

    "español".localize.code_points.should == [101, 115, 112, 97, 241, 111, 108]
    "español".localize.normalize.code_points.should == [101, 115, 112, 97, 110, 771, 111, 108]
    "español".localize.normalize(:using => :NFKD).code_points.should == [101, 115, 112, 97, 110, 771, 111, 108]
  end

  it "verifies Twitter-specific locale conversion" do
    TwitterCldr.convert_locale(:'zh-cn').should == :zh
    TwitterCldr.convert_locale(:zh).should == :zh
    TwitterCldr.convert_locale(:'zh-tw').should == :'zh-Hant'
    TwitterCldr.convert_locale(:'zh-Hant').should == :'zh-Hant'

    TwitterCldr.convert_locale(:msa).should == :ms
    TwitterCldr.convert_locale(:ms).should == :ms
  end

  it "verifies locale defaults" do
    TwitterCldr.locale.should == :en
    TwitterCldr.locale = nil
    FastGettext.locale = "ru"
    TwitterCldr.locale.should == :ru
  end
end