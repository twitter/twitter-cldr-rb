# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr do
  describe "#supported_locale?" do
    it "should return true if the locale is supported" do
      expect(TwitterCldr.supported_locale?(:es)).to be_true
      expect(TwitterCldr.supported_locale?("es")).to be_true
    end

    it "should return false if the locale isn't supported" do
      expect(TwitterCldr.supported_locale?(:bogus)).to be_false
      expect(TwitterCldr.supported_locale?("bogus")).to be_false
    end

    it "should return true if the given locale code is twitter-specific" do
      expect(TwitterCldr.supported_locale?(:'zh-cn')).to be_true
      expect(TwitterCldr.supported_locale?(:'zh-tw')).to be_true
      expect(TwitterCldr.supported_locale?(:msa)).to be_true
    end

    it "should work with lowercase region codes" do
      expect(TwitterCldr.supported_locale?('en-gb')).to be_true
      expect(TwitterCldr.supported_locale?('zh-hant')).to be_true
    end

    it "should work with upper case region codes" do
      expect(TwitterCldr.supported_locale?('en-GB')).to be_true
      expect(TwitterCldr.supported_locale?('zh-Hant')).to be_true
    end
  end

  describe "#supported_locales" do
    it "should return an array of currently supported locale codes" do
      locales = TwitterCldr.supported_locales
      expect(locales).to include(:es)
      expect(locales).to include(:zh)
      expect(locales).to include(:nb)
      expect(locales).to include(:ja)
    end

    it 'should not include :shared or :unicode_data' do
      expect(TwitterCldr.supported_locales & [:shared, :unicode_data]).to be_empty
    end
  end

  describe "#convert_locale" do
    it "should convert a twitter locale to a CLDR locale" do
      expect(TwitterCldr.convert_locale(:msa)).to eq(:ms)
      expect(TwitterCldr.convert_locale(:'zh-cn')).to eq(:zh)
      expect(TwitterCldr.convert_locale(:'zh-tw')).to eq(:'zh-Hant')
    end

    it "should leave unknown locales alone" do
      expect(TwitterCldr.convert_locale(:blarg)).to eq(:blarg)
    end
  end

  describe "#twitter_locale" do
    it "should convert a CLDR locale to a twitter locale" do
      expect(TwitterCldr.twitter_locale(:ms)).to eq(:msa)
      expect(TwitterCldr.twitter_locale(:zh)).to eq(:'zh-cn')
      expect(TwitterCldr.twitter_locale(:'zh-Hant')).to eq(:'zh-tw')
    end

    it "should leave unknown locales alone" do
      expect(TwitterCldr.twitter_locale(:blarg)).to eq(:blarg)
    end
  end

  describe "#locale" do
    context "with explicit locale" do
      it "should return the same locale the user sets (if it's supported)" do
        TwitterCldr.locale = :es
        expect(TwitterCldr.locale).to eq(:es)
      end

      it "should convert strings to symbols" do
        TwitterCldr.locale = "es"
        expect(TwitterCldr.locale).to eq(:es)
      end

      it "should fall back if the user sets an unsupported locale" do
        FastGettext.locale = :ko
        TwitterCldr.locale = "blarg"
        expect(TwitterCldr.locale).to eq(:ko)

        FastGettext.locale = nil
        I18n.locale = :hu
        expect(TwitterCldr.locale).to eq(:hu)
      end
    end

    context "with implicit locale (fallbacks)" do
      before(:each) do
        TwitterCldr.locale = nil
      end

      it "should return FastGettext locale before I18n locale and fall back gracefully" do
        FastGettext.locale = :pt
        I18n.locale = :ar
        expect(TwitterCldr.locale).to eq(:pt)

        FastGettext.locale = nil
        expect(TwitterCldr.locale).to eq(:ar)

        I18n.locale = nil
        expect(TwitterCldr.locale).to eq(:en)
      end

      context "with only FastGettext locale" do
        before(:each) do
          I18n.locale = nil  # disable I18n fallback
        end

        it "should return the FastGettext locale if it's supported" do
          FastGettext.locale = "vi"
          expect(TwitterCldr.locale).to eq(:vi)
        end

        it "should return the default locale if the FastGettext locale is unsupported" do
          FastGettext.locale = "bogus"
          expect(TwitterCldr.locale).to eq(TwitterCldr::DEFAULT_LOCALE)
        end
      end

      context "with only I18n locale" do
        before(:each) do
          FastGettext.locale = nil  # disable FastGettext fallback
        end

        it "should return the I18n locale if it's supported" do
          I18n.locale = "ru"
          expect(TwitterCldr.locale).to eq(:ru)
        end

        it "should return the default locale if the I18n locale is unsupported" do
          I18n.locale = "bogus"
          expect(TwitterCldr.locale).to eq(TwitterCldr::DEFAULT_LOCALE)
        end
      end

      context "with a custom fallback" do
        before(:each) do
          @allow = false
          TwitterCldr.register_locale_fallback(lambda { @allow ? :uk : nil })
        end

        it "should fall back to the custom locale" do
          expect(TwitterCldr.locale).to eq(:en)
          @allow = true
          expect(TwitterCldr.locale).to eq(:uk)
        end

        it "should fall back to the next fallback option if the custom one returns nil" do
          FastGettext.locale = :lv
          expect(TwitterCldr.locale).to eq(:lv)
          @allow = true
          expect(TwitterCldr.locale).to eq(:uk)
        end

        it "should not return the fallback locale if it's unsupported" do
          TwitterCldr.reset_locale_fallbacks
          TwitterCldr.register_locale_fallback(lambda { :zzz })
          expect(TwitterCldr.locale).to eq(:en)
        end
      end

      it "should fall back if the user sets an unsupported locale" do
        FastGettext.locale = :ko
        TwitterCldr.locale = "blarg"
        expect(TwitterCldr.locale).to eq(:ko)

        FastGettext.locale = nil
        I18n.locale = :hu
        expect(TwitterCldr.locale).to eq(:hu)
      end
    end

    context "with implicit locale (fallbacks)" do
      before(:each) do
        TwitterCldr.locale = nil
      end

      it "should return FastGettext locale before I18n locale and fall back gracefully" do
        FastGettext.locale = :pt
        I18n.locale = :ar
        expect(TwitterCldr.locale).to eq(:pt)

        FastGettext.locale = nil
        expect(TwitterCldr.locale).to eq(:ar)

        I18n.locale = nil
        expect(TwitterCldr.locale).to eq(:en)
      end

      context "with only FastGettext locale" do
        before(:each) do
          I18n.locale = nil  # disable I18n fallback
        end

        it "should return the FastGettext locale if it's supported" do
          FastGettext.locale = "vi"
          expect(TwitterCldr.locale).to eq(:vi)
        end

        it "should return the default locale if the FastGettext locale is unsupported" do
          FastGettext.locale = "bogus"
          expect(TwitterCldr.locale).to eq(TwitterCldr::DEFAULT_LOCALE)
        end
      end

      context "with only I18n locale" do
        before(:each) do
          FastGettext.locale = nil  # disable FastGettext fallback
        end

        it "should return the I18n locale if it's supported" do
          I18n.locale = "ru"
          expect(TwitterCldr.locale).to eq(:ru)
        end

        it "should return the default locale if the I18n locale is unsupported" do
          I18n.locale = "bogus"
          expect(TwitterCldr.locale).to eq(TwitterCldr::DEFAULT_LOCALE)
        end
      end

      context "with a custom fallback" do
        before(:each) do
          @allow = false
          TwitterCldr.register_locale_fallback(lambda { @allow ? :uk : nil })
        end

        it "should fall back to the custom locale" do
          expect(TwitterCldr.locale).to eq(:en)
          @allow = true
          expect(TwitterCldr.locale).to eq(:uk)
        end

        it "should fall back to the next fallback option if the custom one returns nil" do
          FastGettext.locale = :lv
          expect(TwitterCldr.locale).to eq(:lv)
          @allow = true
          expect(TwitterCldr.locale).to eq(:uk)
        end

        it "should not return the fallback locale if it's unsupported" do
          TwitterCldr.reset_locale_fallbacks
          TwitterCldr.register_locale_fallback(lambda { :zzz })
          expect(TwitterCldr.locale).to eq(:en)
        end
      end
    end
  end

  describe "#with_locale" do
    it "should only change the locale in the context of the block" do
      expect(TwitterCldr::Shared::Languages.from_code(:es)).to eq("Spanish")
      expect(TwitterCldr.with_locale(:es) { TwitterCldr::Shared::Languages.from_code(:es) }).to match_normalized("español")
      expect(TwitterCldr::Shared::Languages.from_code(:es)).to eq("Spanish")
    end

    it "switches the locale back to the original if the block raises an error" do
      expect(TwitterCldr.locale).to eq(:en)
      locale_inside_block = nil

      expect do
        TwitterCldr.with_locale(:es) do
          locale_inside_block = TwitterCldr.locale
          raise "Error!"
        end
      end.to raise_error

      expect(locale_inside_block).to eq(:es)
      expect(TwitterCldr.locale).to eq(:en)
    end
  end

  describe "#with_locale" do
    it "should only change the locale in the context of the block" do
      expect(TwitterCldr::Shared::Languages.from_code(:es)).to eq("Spanish")
      expect(TwitterCldr.with_locale(:es) { TwitterCldr::Shared::Languages.from_code(:es) }).to match_normalized("español")
      expect(TwitterCldr::Shared::Languages.from_code(:es)).to eq("Spanish")
    end

    it "doesn't mess up if the given locale isn't supported" do
      TwitterCldr.locale = :pt
      expect(TwitterCldr.locale).to eq(:pt)
      expect { TwitterCldr.with_locale(:xx) {} }.to raise_error
      expect(TwitterCldr.locale).to eq(:pt)
    end

    it "switches the locale back to the original if the block raises an error" do
      expect(TwitterCldr.locale).to eq(:en)
      locale_inside_block = nil

      expect do
        TwitterCldr.with_locale(:es) do
          locale_inside_block = TwitterCldr.locale
          raise "Error!"
        end
      end.to raise_error

      expect(locale_inside_block).to eq(:es)
      expect(TwitterCldr.locale).to eq(:en)
    end
  end

  describe '#resources' do
    it 'returns @resources' do
      resources = TwitterCldr::Resources::Loader.new
      TwitterCldr.instance_variable_set(:@resources, resources)

      expect(TwitterCldr.resources).to eq(resources)
    end
  end

  let(:resources) { TwitterCldr::Resources::Loader.new }

  describe '#get_resource' do
    it 'delegates to resources' do
      stub(resources).get_resource(:shared, :currencies) { 'result' }
      stub(TwitterCldr).resources { resources }

      expect(TwitterCldr.get_resource(:shared, :currencies)).to eq('result')
    end
  end

  describe '#get_locale_resource' do
    it 'delegates to resources' do
      stub(resources).get_locale_resource(:de, :numbers) { 'result' }
      stub(TwitterCldr).resources { resources }

      expect(TwitterCldr.get_locale_resource(:de, :numbers)).to eq('result')
    end
  end
end
