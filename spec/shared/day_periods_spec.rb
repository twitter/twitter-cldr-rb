# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Shared::DayPeriods do
  let(:day_periods) { described_class.instance(:en) }

  describe '#period_type_for' do
    subject { day_periods.period_type_for(time) }

    context 'noon' do
      let(:time) { Time.new(1987, 9, 20, 12, 0, 0) }

      it { is_expected.to eq(:noon) }
    end

    context 'midnight' do
      let(:time) { Time.new(1987, 9, 20, 0, 0, 0) }

      it { is_expected.to eq(:midnight) }
    end

    context 'mid-morning' do
      let(:time) { Time.new(1987, 9, 20, 8, 0, 0) }

      it { is_expected.to eq(:morning1) }
    end

    context 'start of morning' do
      let(:time) { Time.new(1987, 9, 20, 6, 0, 0) }

      it { is_expected.to eq(:morning1) }
    end

    context 'barely not morning' do
      let(:time) { Time.new(1987, 9, 20, 12, 0, 0) }

      it { is_expected.to_not eq(:morning1) }
    end

    context 'mid-afternoon' do
      let(:time) { Time.new(1987, 9, 20, 15, 0, 0) }

      it { is_expected.to eq(:afternoon1) }
    end

    context 'start of afternoon' do
      let(:time) { Time.new(1987, 9, 20, 12, 0, 1) }

      it { is_expected.to eq(:afternoon1) }
    end

    context 'barely not afternoon' do
      let(:time) { Time.new(1987, 9, 20, 18, 0, 0) }

      it { is_expected.to_not eq(:afternoon1) }
    end

    context 'middle of the night' do
      let(:time) { Time.new(1987, 9, 20, 22, 0, 0) }

      it { is_expected.to eq(:night1) }
    end

    context 'after midnight' do
      let(:time) { Time.new(1987, 9, 20, 2, 0, 0) }

      it { is_expected.to eq(:night1) }
    end

    context 'barely not night' do
      let(:time) { Time.new(1987, 9, 20, 6, 0, 0) }

      it { is_expected.to_not eq(:night1) }
    end

    it 'does not raise an error for every locale and hour combo' do
      TwitterCldr.supported_locales.each do |locale|
        day_periods = described_class.instance(locale)

        (0..23).each do |hour|
          time = Time.new(1987, 9, 20, hour, 0, 1)
          expect { day_periods.period_type_for(time) }.to_not raise_error
        end

        midnight = Time.new(1987, 9, 20, 0, 0, 0)
        expect { day_periods.period_type_for(midnight) }.to_not raise_error

        noon = Time.new(1987, 9, 20, 12, 0, 0)
        expect { day_periods.period_type_for(noon) }.to_not raise_error
      end
    end
  end
end
