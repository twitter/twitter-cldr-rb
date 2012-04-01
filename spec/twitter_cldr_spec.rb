require File.join(File.dirname(__FILE__), "spec_helper")

describe TwitterCldr do
  describe "#supported_locale?" do
    it "should return true if the locale is supported" do
      TwitterCldr.supported_locale?(:es).should be_true
      TwitterCldr.supported_locale?("es").should be_true
    end

    it "should return false if the locale isn't supported" do
      TwitterCldr.supported_locale?(:bogus).should be_false
      TwitterCldr.supported_locale?("bogus").should be_false
    end

    it "should return true if the given locale code is twitter-specific" do
      TwitterCldr.supported_locale?(:'zh-cn').should be_true
      TwitterCldr.supported_locale?(:'zh-tw').should be_true
      TwitterCldr.supported_locale?(:msa).should be_true
    end
  end

  describe "#supported_locales" do
    it "should return an array of currently supported locale codes" do
      locales = TwitterCldr.supported_locales
      locales.should include(:es)
      locales.should include(:zh)
      locales.should include(:no)
      locales.should include(:ja)
    end
  end

  describe "#convert_locale" do
    it "should convert a twitter locale to a CLDR locale" do
      TwitterCldr.convert_locale(:msa).should == :ms
      TwitterCldr.convert_locale(:'zh-cn').should == :zh
      TwitterCldr.convert_locale(:'zh-tw').should == :'zh-Hant'
    end
  end

  describe "#get_locale" do
    context "with FastGettext locale" do
      it "should return the FastGettext locale" do
        mock(FastGettext).locale { "es" }
        TwitterCldr.get_locale.should == :es
      end

      it "should return the default locale if the FastGettext locale is unsupported" do
        mock(FastGettext).locale { "bogus" }
        TwitterCldr.get_locale.should == TwitterCldr::DEFAULT_LOCALE
      end
    end
  end
end
