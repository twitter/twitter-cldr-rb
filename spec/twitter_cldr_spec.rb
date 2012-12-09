# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

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
      locales.should include(:nb)
      locales.should include(:ja)
    end

    it 'should not include :shared or :unicode_data' do
      (TwitterCldr.supported_locales & [:shared, :unicode_data]).should be_empty
    end
  end

  describe "#convert_locale" do
    it "should convert a twitter locale to a CLDR locale" do
      TwitterCldr.convert_locale(:msa).should == :ms
      TwitterCldr.convert_locale(:'zh-cn').should == :zh
      TwitterCldr.convert_locale(:'zh-tw').should == :'zh-Hant'
    end

    it "should leave unknown locales alone" do
      TwitterCldr.convert_locale(:blarg).should == :blarg
    end
  end

  describe "#twitter_locale" do
    it "should convert a CLDR locale to a twitter locale" do
      TwitterCldr.twitter_locale(:ms).should == :msa
      TwitterCldr.twitter_locale(:zh).should == :'zh-cn'
      TwitterCldr.twitter_locale(:'zh-Hant').should == :'zh-tw'
    end

    it "should leave unknown locales alone" do
      TwitterCldr.twitter_locale(:blarg).should == :blarg
    end
  end

  describe "#locale" do
    context "with explicit locale" do
      it "should return the same locale the user sets (if it's supported)" do
        TwitterCldr.locale = :es
        TwitterCldr.locale.should == :es
      end

      it "should convert strings to symbols" do
        TwitterCldr.locale = "es"
        TwitterCldr.locale.should == :es
      end

      it "should fall back if the user sets an unsupported locale" do
        FastGettext.locale = :ko
        TwitterCldr.locale = "blarg"
        TwitterCldr.locale.should == :ko

        FastGettext.locale = nil
        I18n.locale = :hu
        TwitterCldr.locale.should == :hu
      end
    end

    context "with implicit locale (fallbacks)" do
      before(:each) do
        TwitterCldr.locale = nil
      end

      it "should return FastGettext locale before I18n locale and fall back gracefully" do
        FastGettext.locale = :pt
        I18n.locale = :ar
        TwitterCldr.locale.should == :pt

        FastGettext.locale = nil
        TwitterCldr.locale.should == :ar

        I18n.locale = nil
        TwitterCldr.locale.should == :en
      end

      context "with only FastGettext locale" do
        before(:each) do
          I18n.locale = nil  # disable I18n fallback
        end

        it "should return the FastGettext locale if it's supported" do
          FastGettext.locale = "vi"
          TwitterCldr.locale.should == :vi
        end

        it "should return the default locale if the FastGettext locale is unsupported" do
          FastGettext.locale = "bogus"
          TwitterCldr.locale.should == TwitterCldr::DEFAULT_LOCALE
        end
      end

      context "with only I18n locale" do
        before(:each) do
          FastGettext.locale = nil  # disable FastGettext fallback
        end

        it "should return the I18n locale if it's supported" do
          I18n.locale = "ru"
          TwitterCldr.locale.should == :ru
        end

        it "should return the default locale if the I18n locale is unsupported" do
          I18n.locale = "bogus"
          TwitterCldr.locale.should == TwitterCldr::DEFAULT_LOCALE
        end
      end

      context "with a custom fallback" do
        before(:each) do
          @allow = false
          TwitterCldr.register_locale_fallback(lambda { @allow ? :uk : nil })
        end

        it "should fall back to the custom locale" do
          TwitterCldr.locale.should == :en
          @allow = true
          TwitterCldr.locale.should == :uk
        end

        it "should fall back to the next fallback option if the custom one returns nil" do
          FastGettext.locale = :lv
          TwitterCldr.locale.should == :lv
          @allow = true
          TwitterCldr.locale.should == :uk
        end

        it "should not return the fallback locale if it's unsupported" do
          TwitterCldr.reset_locale_fallbacks
          TwitterCldr.register_locale_fallback(lambda { :zzz })
          TwitterCldr.locale.should == :en
        end
      end
    end
  end

  describe '#resources' do
    it 'returns @resources' do
      resources = TwitterCldr::Resources::Loader.new
      TwitterCldr.instance_variable_set(:@resources, resources)

      TwitterCldr.resources.should == resources
    end
  end

  let(:resources) { TwitterCldr::Resources::Loader.new }

  describe '#get_resource' do
    it 'delegates to resources' do
      stub(resources).get_resource(:shared, :currencies) { 'result' }
      stub(TwitterCldr).resources { resources }

      TwitterCldr.get_resource(:shared, :currencies).should == 'result'
    end
  end

  describe '#get_locale_resource' do
    it 'delegates to resources' do
      stub(resources).get_locale_resource(:de, :numbers) { 'result' }
      stub(TwitterCldr).resources { resources }

      TwitterCldr.get_locale_resource(:de, :numbers).should == 'result'
    end
  end
end