# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Unit do
  describe '.create' do
    it 'instantiates a new unit object' do
      unit = Unit.create(1234, :en)
      expect(unit).to be_a(Unit)
      expect(unit).to respond_to(:length_mile)
    end
  end

  describe '#unit_types' do
    let(:unit) { Unit.create(42, :en) }

    it 'lists all possible unit types' do
      expect(unit.unit_types).to include(:mass_kilogram)
      expect(unit.unit_types).to include(:length_mile)
      expect(unit.unit_types).to include(:temperature_celsius)
    end
  end

  describe 'en' do
    let(:locale) { :en }

    it 'uses number formatting rules when appropriate' do
      expect(Unit.create(1234, locale).volume_liter).to eq('1,234 liters')
    end

    it 'does not format numbers if given a string' do
      expect(Unit.create('1234', locale).volume_liter).to eq('1234 liters')
    end

    describe 'long form' do
      describe '#length_mile' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).length_mile).to eq('1 mile')
          expect(Unit.create(2, locale).length_mile).to eq('2 miles')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).temperature_celsius).to eq('1 degree Celsius')
          expect(Unit.create(2, locale).temperature_celsius).to eq('2 degrees Celsius')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).mass_kilogram).to eq('1 kilogram')
          expect(Unit.create(2, locale).mass_kilogram).to eq('2 kilograms')
        end
      end
    end

    describe 'narrow form' do
      let(:options) { { form: :narrow } }

      describe '#length_mile' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).length_mile(options)).to eq('1mi')
          expect(Unit.create(2, locale).length_mile(options)).to eq('2mi')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).temperature_celsius(options)).to eq('1°C')
          expect(Unit.create(2, locale).temperature_celsius(options)).to eq('2°C')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).mass_kilogram(options)).to eq('1kg')
          expect(Unit.create(2, locale).mass_kilogram(options)).to eq('2kg')
        end
      end
    end

    describe 'short form' do
      let(:options) { { form: :short } }

      describe '#length_mile' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).length_mile(options)).to eq('1 mi')
          expect(Unit.create(2, locale).length_mile(options)).to eq('2 mi')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).temperature_celsius(options)).to eq('1°C')
          expect(Unit.create(2, locale).temperature_celsius(options)).to eq('2°C')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).mass_kilogram(options)).to eq('1 kg')
          expect(Unit.create(2, locale).mass_kilogram(options)).to eq('2 kg')
        end
      end
    end
  end

  describe 'ru' do
    let(:locale) { :ru }

    it 'uses number formatting rules when appropriate' do
      expect(Unit.create(1234, locale).volume_liter).to eq('1 234 литра')
    end

    it 'does not format numbers if given a string' do
      expect(Unit.create('1234', locale).volume_liter).to eq('1234 литра')
    end

    describe 'long form' do
      describe '#length_mile' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).length_mile).to eq('1 миля')
          expect(Unit.create(2, locale).length_mile).to eq('2 мили')
          expect(Unit.create(7, locale).length_mile).to eq('7 миль')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).temperature_celsius).to eq('1градус Цельсия')
          expect(Unit.create(2, locale).temperature_celsius).to eq('2 градуса Цельсия')
          expect(Unit.create(7, locale).temperature_celsius).to eq('7градусов Цельсия')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).mass_kilogram).to eq('1 килограмм')
          expect(Unit.create(2, locale).mass_kilogram).to eq('2 килограмма')
          expect(Unit.create(7, locale).mass_kilogram).to eq('7 килограмм')
        end
      end
    end

    describe 'narrow form' do
      let(:options) { { form: :narrow } }

      describe '#length_mile' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).length_mile(options)).to eq('1 миля')
          expect(Unit.create(2, locale).length_mile(options)).to eq('2 миль')
          expect(Unit.create(7, locale).length_mile(options)).to eq('7 миль')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).temperature_celsius(options)).to eq('1 °C')
          expect(Unit.create(2, locale).temperature_celsius(options)).to eq('2 °C')
          expect(Unit.create(7, locale).temperature_celsius(options)).to eq('7 °C')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).mass_kilogram(options)).to eq('1 кг')
          expect(Unit.create(2, locale).mass_kilogram(options)).to eq('2 кг')
          expect(Unit.create(7, locale).mass_kilogram(options)).to eq('7 кг')
        end
      end
    end

    describe 'short form' do
      let(:options) { { form: :short } }

      describe '#length_mile' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).length_mile(options)).to eq('1 миля')
          expect(Unit.create(2, locale).length_mile(options)).to eq('2 мили')
          expect(Unit.create(7, locale).length_mile(options)).to eq('7 миль')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).temperature_celsius(options)).to eq('1 °C')
          expect(Unit.create(2, locale).temperature_celsius(options)).to eq('2 °C')
          expect(Unit.create(7, locale).temperature_celsius(options)).to eq('7 °C')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).mass_kilogram(options)).to eq('1 кг')
          expect(Unit.create(2, locale).mass_kilogram(options)).to eq('2 кг')
          expect(Unit.create(7, locale).mass_kilogram(options)).to eq('7 кг')
        end
      end
    end
  end

  describe 'ko' do
    let(:locale) { :ko }

    it 'uses number formatting rules when appropriate' do
      expect(Unit.create(1234, locale).volume_liter).to eq('1,234리터')
    end

    it 'does not format numbers if given a string' do
      expect(Unit.create('1234', locale).volume_liter).to eq('1234리터')
    end

    describe 'long form' do
      describe '#length_mile' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).length_mile).to eq('1마일')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).temperature_celsius).to eq('섭씨 1도')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).mass_kilogram).to eq('1킬로그램')
        end
      end
    end

    describe 'narrow form' do
      let(:options) { { form: :narrow } }

      describe '#length_mile' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).length_mile(options)).to eq('1mi')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).temperature_celsius(options)).to eq('1°C')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).mass_kilogram(options)).to eq('1kg')
        end
      end
    end

    describe 'short form' do
      let(:options) { { form: :short } }

      describe '#length_mile' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).length_mile(options)).to eq('1mi')
        end
      end

      describe '#temperature_celsius' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).temperature_celsius(options)).to eq('1°C')
        end
      end

      describe '#mass_kilogram' do
        it 'produces the correct results' do
          expect(Unit.create(1, locale).mass_kilogram(options)).to eq('1kg')
        end
      end
    end
  end
end
