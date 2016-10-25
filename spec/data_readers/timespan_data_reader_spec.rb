# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::DataReaders

describe TimespanDataReader do
  it 'sets default options and identifies plural rule' do
    data_reader = TimespanDataReader.new(:sv, 2)
    expect(data_reader.locale).to eq(:sv)
    expect(data_reader.type).to eq(:default)
    expect(data_reader.direction).to eq(:ago)
    expect(data_reader.unit).to eq(nil)
    expect(data_reader.plural_rule).to eq(:other)
  end

  describe '#pattern' do
    test_cases = {
      ago: {
        default: {
          second: 'för {0} sekunder sedan',
          minute: 'för {0} minuter sedan',
          hour: 'för {0} timmar sedan',
          day: 'för {0} dagar sedan',
          week: 'för {0} veckor sedan',
          month: 'för {0} månader sedan',
          year: 'för {0} år sedan'
        },

        narrow: {
          second: '−{0} s',
          minute: '−{0} min',
          hour: '−{0} h',
          day: '−{0} d',
          week: '-{0} v.',
          month: '-{0} mån.',
          year: '-{0} år'
        }
      },

      until: {
        default: {
          second: 'om {0} sekunder',
          minute: 'om {0} minuter',
          hour: 'om {0} timmar',
          day: 'om {0} dagar',
          week: 'om {0} veckor',
          month: 'om {0} månader',
          year: 'om {0} år'
        },

        narrow: {
          second: '+{0} s',
          minute: '+{0} m',
          hour: '+{0} h',
          day: '+{0} d',
          week: '+{0} v.',
          month: '+{0} mån.',
          year: '+{0} år'
        }
      }
    }

    test_cases.each_pair do |direction, dir_hash|
      dir_hash.each_pair do |type, type_hash|
        type_hash.each_pair do |unit, expected_value|
          it "finds the correct pattern with direction '#{direction}', type '#{type}', and unit '#{unit}'" do
            data_reader = TimespanDataReader.new(:sv, 2, {
              direction: direction, type: type, unit: unit
            })

            expect(data_reader.pattern).to match_normalized(expected_value)
          end
        end
      end
    end
  end
end
