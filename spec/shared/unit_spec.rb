# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Shared::Unit do
  describe '.create' do
    it 'instantiates a new unit object' do
      unit = described_class.create(1234, :en)
      expect(unit).to be_a(described_class)
      expect(unit).to respond_to(:length_mile)
    end
  end

  describe '#unit_types' do
    let(:unit) { described_class.create(42, :en) }

    it 'lists all possible unit types' do
      expect(unit.unit_types).to include(:mass_kilogram)
      expect(unit.unit_types).to include(:length_mile)
      expect(unit.unit_types).to include(:temperature_celsius)
    end
  end

  describe 'en' do
    let(:locale) { :en }

    it 'uses number formatting rules when appropriate' do
      expect(described_class.create(1234, locale).volume_liter).to eq('1,234 liters')
    end

    it 'does not format numbers if given a string' do
      expect(described_class.create('1234', locale).volume_liter).to eq('1234 liters')
    end

    describe 'long form' do
      describe '#length_mile' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).length_mile).to eq('1 mile')
          expect(described_class.create(2, locale).length_mile).to eq('2 miles')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).temperature_celsius).to eq('1 degree Celsius')
          expect(described_class.create(2, locale).temperature_celsius).to eq('2 degrees Celsius')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).mass_kilogram).to eq('1 kilogram')
          expect(described_class.create(2, locale).mass_kilogram).to eq('2 kilograms')
        end
      end
    end

    describe 'narrow form' do
      let(:options) { { form: :narrow } }

      describe '#length_mile' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).length_mile(options)).to eq('1mi')
          expect(described_class.create(2, locale).length_mile(options)).to eq('2mi')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).temperature_celsius(options)).to eq('1°C')
          expect(described_class.create(2, locale).temperature_celsius(options)).to eq('2°C')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).mass_kilogram(options)).to eq('1kg')
          expect(described_class.create(2, locale).mass_kilogram(options)).to eq('2kg')
        end
      end
    end

    describe 'short form' do
      let(:options) { { form: :short } }

      describe '#length_mile' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).length_mile(options)).to eq('1 mi')
          expect(described_class.create(2, locale).length_mile(options)).to eq('2 mi')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).temperature_celsius(options)).to eq('1°C')
          expect(described_class.create(2, locale).temperature_celsius(options)).to eq('2°C')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).mass_kilogram(options)).to eq('1 kg')
          expect(described_class.create(2, locale).mass_kilogram(options)).to eq('2 kg')
        end
      end
    end
  end

  describe 'ru' do
    let(:locale) { :ru }

    it 'uses number formatting rules when appropriate' do
      expect(described_class.create(1234, locale).volume_liter).to eq('1 234 литра')
    end

    it 'does not format numbers if given a string' do
      expect(described_class.create('1234', locale).volume_liter).to eq('1234 литра')
    end

    describe 'long form' do
      describe '#length_mile' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).length_mile).to eq('1 миля')
          expect(described_class.create(2, locale).length_mile).to eq('2 мили')
          expect(described_class.create(7, locale).length_mile).to eq('7 миль')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).temperature_celsius).to eq('1 градус Цельсия')
          expect(described_class.create(2, locale).temperature_celsius).to eq('2 градуса Цельсия')
          expect(described_class.create(7, locale).temperature_celsius).to eq('7 градусов Цельсия')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).mass_kilogram).to eq('1 килограмм')
          expect(described_class.create(2, locale).mass_kilogram).to eq('2 килограмма')
          expect(described_class.create(7, locale).mass_kilogram).to eq('7 килограмм')
        end
      end
    end

    describe 'narrow form' do
      let(:options) { { form: :narrow } }

      describe '#length_mile' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).length_mile(options)).to eq('1 миля')
          expect(described_class.create(2, locale).length_mile(options)).to eq('2 миль')
          expect(described_class.create(7, locale).length_mile(options)).to eq('7 миль')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).temperature_celsius(options)).to eq('1 °C')
          expect(described_class.create(2, locale).temperature_celsius(options)).to eq('2 °C')
          expect(described_class.create(7, locale).temperature_celsius(options)).to eq('7 °C')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).mass_kilogram(options)).to eq('1 кг')
          expect(described_class.create(2, locale).mass_kilogram(options)).to eq('2 кг')
          expect(described_class.create(7, locale).mass_kilogram(options)).to eq('7 кг')
        end
      end
    end

    describe 'short form' do
      let(:options) { { form: :short } }

      describe '#length_mile' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).length_mile(options)).to eq('1 ми')
          expect(described_class.create(2, locale).length_mile(options)).to eq('2 ми')
          expect(described_class.create(7, locale).length_mile(options)).to eq('7 ми')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).temperature_celsius(options)).to eq('1 °C')
          expect(described_class.create(2, locale).temperature_celsius(options)).to eq('2 °C')
          expect(described_class.create(7, locale).temperature_celsius(options)).to eq('7 °C')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).mass_kilogram(options)).to eq('1 кг')
          expect(described_class.create(2, locale).mass_kilogram(options)).to eq('2 кг')
          expect(described_class.create(7, locale).mass_kilogram(options)).to eq('7 кг')
        end
      end
    end
  end

  describe 'ko' do
    let(:locale) { :ko }

    it 'uses number formatting rules when appropriate' do
      expect(described_class.create(1234, locale).volume_liter).to eq('1,234리터')
    end

    it 'does not format numbers if given a string' do
      expect(described_class.create('1234', locale).volume_liter).to eq('1234리터')
    end

    describe 'long form' do
      describe '#length_mile' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).length_mile).to eq('1마일')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).temperature_celsius).to eq('섭씨 1도')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).mass_kilogram).to eq('1킬로그램')
        end
      end
    end

    describe 'narrow form' do
      let(:options) { { form: :narrow } }

      describe '#length_mile' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).length_mile(options)).to eq('1mi')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).mass_kilogram(options)).to eq('1kg')
        end
      end
    end

    describe 'short form' do
      let(:options) { { form: :short } }

      describe '#length_mile' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).length_mile(options)).to eq('1mi')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).temperature_celsius(options)).to eq('1°C')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(described_class.create(1, locale).mass_kilogram(options)).to eq('1kg')
        end
      end
    end
  end
end
