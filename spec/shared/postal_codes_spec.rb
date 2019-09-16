# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Shared::PostalCodes do
  describe "#territories" do
    let(:territories) { described_class.territories }

    it 'returns an array' do
      expect(territories).to be_instance_of(Array)
    end

    it 'returns symbols' do
      territories.each { |territory| expect(territory).to be_instance_of(Symbol) }
    end

    it 'returns supported territories' do
      expect(territories).to include(:br, :fr, :jp)
    end
  end

  describe "#new" do
    it "should raise an error if the territory isn't supported" do
      expect { described_class.for_territory(:xx) }.to(
        raise_error(TwitterCldr::Shared::InvalidTerritoryError)
      )
    end

    it 'accepts strings' do
      expect(described_class.for_territory("us")).to be_a(described_class)
    end

    it 'accepts upper-case strings' do
      expect(described_class.for_territory("US")).to be_a(described_class)
    end
  end

  context "with a PostalCodes instance" do
    let(:postal_code) { described_class.for_territory(:us) }

    describe '#regexp' do
      it 'returns postal code regex for a given territory' do
        expect(postal_code.regexp).to be_a(Regexp)
      end
    end

    describe '#find_all' do
      it 'matches valid postal codes' do
        expect(postal_code.find_all("12345 23456")).to eql(['12345', '23456'])
      end

      it 'does not match invalid postal codes' do
        expect(postal_code.find_all("123456 23456")).to eql(['23456'])
        expect(postal_code.find_all("12345 234567")).to eql(['12345'])
        expect(postal_code.find_all("12345 234567 34567")).to eql(['12345', '34567'])
      end
    end

    describe '#valid?' do
      it 'returns true if a given postal code satisfies the regexp' do
        expect(postal_code.valid?('12345-6789')).to eq(true)
      end

      it 'returns false if a given postal code adds extra characters to an otherwise valid code' do
        expect(postal_code.valid?('123456')).to eq(false)
      end

      it "returns false if a given postal code doesn't satisfy the regexp" do
        expect(postal_code.valid?('postal-code')).to eq(false)
      end
    end

    describe "#sample" do
      described_class.territories.each do |territory|
        next unless territory == :sh
        postal_code = described_class.for_territory(territory)

        it "returns samples that match #{territory}" do
          if postal_code.has_generator?
            postal_code.sample(10).each do |sample|
              result = postal_code.valid?(sample)
              puts "Failed with example #{sample}" unless result
              expect(result).to eq(true)
            end
          end
        end
      end
    end
  end

  context 'with a postal code that has no AST' do
    let(:postal_code) { described_class.new(:xx, /\d{5}/, nil) }

    describe '#sample' do
      it 'raises an exception' do
        expect { postal_code.sample }.to raise_error(
          TwitterCldr::Shared::MissingPostcodeGeneratorError
        )
      end
    end

    describe '#has_generator?' do
      it 'returns false' do
        expect(postal_code).to_not have_generator
      end
    end
  end
end
