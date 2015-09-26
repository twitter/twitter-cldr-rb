# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters
include TwitterCldr::Tokenizers

describe DateTimeFormatter do
  before(:each) do
    data_reader = TwitterCldr::DataReaders::DateTimeDataReader.new(:de)
    @formatter = DateTimeFormatter.new(data_reader)
  end

  describe 'plaintext' do
    it "removes single quotes around plaintext tokens" do
      tokens = [Token.new(value: "'at'", type: 'plaintext')]
      date = Date.new(2010, 1, 10)
      expect(@formatter.format(tokens, date, {})).to eq("at")
    end
  end

  describe "#day" do
    it "test: pattern d" do
      expect(@formatter.send(:day, Date.new(2010, 1,  1), 'd', 1)).to eq('1')
      expect(@formatter.send(:day, Date.new(2010, 1, 10), 'd', 1)).to eq('10')
    end

    it "test: pattern dd" do
      expect(@formatter.send(:day, Date.new(2010, 1,  1), 'dd', 2)).to eq('01')
      expect(@formatter.send(:day, Date.new(2010, 1, 10), 'dd', 2)).to eq('10')
    end
  end

  describe "#weekday_local_stand_alone" do
    it "test: pattern c" do
      expect(@formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,   4), 'c', 1)).to eq('1')
      expect(@formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,   5), 'c', 1)).to eq('2')
      expect(@formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,  10), 'c', 1)).to eq('7')
    end

    it "test: pattern cc" do
      expect(@formatter.send(:weekday_local_stand_alone, Date.new(2010, 1, 4),  'cc',  2)).to eq('Mo.')
      expect(@formatter.send(:weekday_local_stand_alone, Date.new(2010, 1, 5),  'cc',  2)).to eq('Di.')
      expect(@formatter.send(:weekday_local_stand_alone, Date.new(2010, 1, 10), 'cc',  2)).to eq('So.')
    end

    it "test: pattern ccc" do
      expect(@formatter.send(:weekday_local_stand_alone, Date.new(2010, 1, 4),  'ccc',  3)).to eq('Mo.')
      expect(@formatter.send(:weekday_local_stand_alone, Date.new(2010, 1, 5),  'ccc',  3)).to eq('Di.')
      expect(@formatter.send(:weekday_local_stand_alone, Date.new(2010, 1, 10), 'ccc',  3)).to eq('So.')
    end

    it "test: pattern cccc" do
      expect(@formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,   4), 'cccc', 4)).to eq('Montag')
      expect(@formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,   5), 'cccc', 4)).to eq('Dienstag')
      expect(@formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,  10), 'cccc', 4)).to eq('Sonntag')
    end

    it "test: pattern ccccc" do
      expect(@formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,   4), 'ccccc', 5)).to eq('M')
      expect(@formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,   5), 'ccccc', 5)).to eq('D')
      expect(@formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,  10), 'ccccc', 5)).to eq('S')
    end
  end

  describe "#weekday_local" do
    it "test: pattern e" do
      expect(@formatter.send(:weekday_local, Date.new(2010, 1,   4), 'e', 1)).to eq('1')
      expect(@formatter.send(:weekday_local, Date.new(2010, 1,   5), 'e', 1)).to eq('2')
      expect(@formatter.send(:weekday_local, Date.new(2010, 1,  10), 'e', 1)).to eq('7')
    end

    it "test: pattern ee" do
      expect(@formatter.send(:weekday_local, Date.new(2010, 1,   4), 'ee', 2)).to eq('1')
      expect(@formatter.send(:weekday_local, Date.new(2010, 1,   5), 'ee', 2)).to eq('2')
      expect(@formatter.send(:weekday_local, Date.new(2010, 1,  10), 'ee', 2)).to eq('7')
    end

    it "test: pattern eee" do
      expect(@formatter.send(:weekday_local, Date.new(2010, 1,   4), 'eee', 3)).to eq('Mo.')
      expect(@formatter.send(:weekday_local, Date.new(2010, 1,   5), 'eee', 3)).to eq('Di.')
      expect(@formatter.send(:weekday_local, Date.new(2010, 1,  10), 'eee', 3)).to eq('So.')
    end

    it "test: pattern eeee" do
      expect(@formatter.send(:weekday_local, Date.new(2010, 1,   4), 'eeee', 4)).to eq('Montag')
      expect(@formatter.send(:weekday_local, Date.new(2010, 1,   5), 'eeee', 4)).to eq('Dienstag')
      expect(@formatter.send(:weekday_local, Date.new(2010, 1,  10), 'eeee', 4)).to eq('Sonntag')
    end

    it "test: pattern eeeee" do
      expect(@formatter.send(:weekday_local, Date.new(2010, 1,   4), 'eeeee', 5)).to eq('M')
      expect(@formatter.send(:weekday_local, Date.new(2010, 1,   5), 'eeeee', 5)).to eq('D')
      expect(@formatter.send(:weekday_local, Date.new(2010, 1,  10), 'eeeee', 5)).to eq('S')
    end
  end

  describe "#weekday" do
    it "test: pattern E, EE, EEE" do
      expect(@formatter.send(:weekday, Date.new(2010, 1, 1), 'E',   1)).to eq('Fr.')
      expect(@formatter.send(:weekday, Date.new(2010, 1, 1), 'EE',  2)).to eq('Fr.')
      expect(@formatter.send(:weekday, Date.new(2010, 1, 1), 'EEE', 3)).to eq('Fr.')
    end

    it "test: pattern EEEE" do
      expect(@formatter.send(:weekday, Date.new(2010, 1, 1), 'EEEE', 4)).to eq('Freitag')
    end

    it "test: pattern EEEEE" do
      expect(@formatter.send(:weekday, Date.new(2010, 1, 1), 'EEEEE', 5)).to eq('F')
    end
  end

  describe "#hour" do
    it "test: h" do
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'h', 1)).to eq('12')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'h', 1)).to eq('1')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'h', 1)).to eq('11')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'h', 1)).to eq('12')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'h', 1)).to eq('11')
    end

    it "test: hh" do
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'hh', 2)).to eq('12')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'hh', 2)).to eq('01')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'hh', 2)).to eq('11')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'hh', 2)).to eq('12')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'hh', 2)).to eq('11')
    end

    it "test: H" do
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'H', 1)).to eq('0')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'H', 1)).to eq('1')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'H', 1)).to eq('11')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'H', 1)).to eq('12')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'H', 1)).to eq('23')
    end

    it "test: HH" do
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'HH', 2)).to eq('00')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'HH', 2)).to eq('01')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'HH', 2)).to eq('11')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'HH', 2)).to eq('12')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'HH', 2)).to eq('23')
    end

    it "test: K" do
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'K', 1)).to eq('0')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'K', 1)).to eq('1')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'K', 1)).to eq('11')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'K', 1)).to eq('0')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'K', 1)).to eq('11')
    end

    it "test: KK" do
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'KK', 2)).to eq('00')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'KK', 2)).to eq('01')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'KK', 2)).to eq('11')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'KK', 2)).to eq('00')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'KK', 2)).to eq('11')
    end

    it "test: k" do
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'k', 1)).to eq('24')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'k', 1)).to eq('1')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'k', 1)).to eq('11')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'k', 1)).to eq('12')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'k', 1)).to eq('23')
    end

    it "test: kk" do
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'kk', 2)).to eq('24')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'kk', 2)).to eq('01')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'kk', 2)).to eq('11')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'kk', 2)).to eq('12')
      expect(@formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'kk', 2)).to eq('23')
    end
  end

  describe "#minute" do
    it "test: m" do
      expect(@formatter.send(:minute, Time.local(2000, 1, 1, 1,  1, 1), 'm', 1)).to eq('1')
      expect(@formatter.send(:minute, Time.local(2000, 1, 1, 1, 11, 1), 'm', 1)).to eq('11')
    end

    it "test: mm" do
      expect(@formatter.send(:minute, Time.local(2000, 1, 1, 1,  1, 1), 'mm', 2)).to eq('01')
      expect(@formatter.send(:minute, Time.local(2000, 1, 1, 1, 11, 1), 'mm', 2)).to eq('11')
    end
  end

  describe "#month" do
    it "test: pattern M" do
      expect(@formatter.send(:month, Date.new(2010,  1, 1), 'M', 1)).to eq('1')
      expect(@formatter.send(:month, Date.new(2010, 10, 1), 'M', 1)).to eq('10')
    end

    it "test: pattern MM" do
      expect(@formatter.send(:month, Date.new(2010,  1, 1), 'MM', 2)).to eq('01')
      expect(@formatter.send(:month, Date.new(2010, 10, 1), 'MM', 2)).to eq('10')
    end

    it "test: pattern MMM" do
      expect(@formatter.send(:month, Date.new(2010,  1, 1), 'MMM', 3)).to eq('Jan.')
      expect(@formatter.send(:month, Date.new(2010, 10, 1), 'MMM', 3)).to eq('Okt.')
    end

    it "test: pattern MMMM" do
      expect(@formatter.send(:month, Date.new(2010,  1, 1), 'MMMM', 4)).to eq('Januar')
      expect(@formatter.send(:month, Date.new(2010, 10, 1), 'MMMM', 4)).to eq('Oktober')
    end

    it "test: pattern L" do
      expect(@formatter.send(:month, Date.new(2010,  1, 1), 'L', 1)).to eq('1')
      expect(@formatter.send(:month, Date.new(2010, 10, 1), 'L', 1)).to eq('10')
    end

    it "test: pattern LL" do
      expect(@formatter.send(:month, Date.new(2010,  1, 1), 'LL', 2)).to eq('01')
      expect(@formatter.send(:month, Date.new(2010, 10, 1), 'LL', 2)).to eq('10')
    end
  end

  describe "#period" do
    it "test: a" do
      expect(@formatter.send(:period, Time.local(2000, 1, 1, 1, 1, 1), 'a', 1)).to eq('vorm.')
      expect(@formatter.send(:period, Time.local(2000, 1, 1, 15, 1, 1), 'a', 1)).to eq('nachm.')
    end
  end

  describe "#quarter" do
    it "test: pattern Q" do
      expect(@formatter.send(:quarter, Date.new(2010, 1,  1),  'Q', 1)).to eq('1')
      expect(@formatter.send(:quarter, Date.new(2010, 3, 31),  'Q', 1)).to eq('1')
      expect(@formatter.send(:quarter, Date.new(2010, 4,  1),  'Q', 1)).to eq('2')
      expect(@formatter.send(:quarter, Date.new(2010, 6, 30),  'Q', 1)).to eq('2')
      expect(@formatter.send(:quarter, Date.new(2010, 7,  1),  'Q', 1)).to eq('3')
      expect(@formatter.send(:quarter, Date.new(2010, 9, 30),  'Q', 1)).to eq('3')
      expect(@formatter.send(:quarter, Date.new(2010, 10,  1), 'Q', 1)).to eq('4')
      expect(@formatter.send(:quarter, Date.new(2010, 12, 31), 'Q', 1)).to eq('4')
    end

    it "test: pattern QQ" do
      expect(@formatter.send(:quarter, Date.new(2010, 1,  1),  'QQ', 2)).to eq('01')
      expect(@formatter.send(:quarter, Date.new(2010, 3, 31),  'QQ', 2)).to eq('01')
      expect(@formatter.send(:quarter, Date.new(2010, 4,  1),  'QQ', 2)).to eq('02')
      expect(@formatter.send(:quarter, Date.new(2010, 6, 30),  'QQ', 2)).to eq('02')
      expect(@formatter.send(:quarter, Date.new(2010, 7,  1),  'QQ', 2)).to eq('03')
      expect(@formatter.send(:quarter, Date.new(2010, 9, 30),  'QQ', 2)).to eq('03')
      expect(@formatter.send(:quarter, Date.new(2010, 10,  1), 'QQ', 2)).to eq('04')
      expect(@formatter.send(:quarter, Date.new(2010, 12, 31), 'QQ', 2)).to eq('04')
    end

    it "test: pattern QQQ" do
      expect(@formatter.send(:quarter, Date.new(2010, 1,  1),  'QQQ', 3)).to eq('Q1')
      expect(@formatter.send(:quarter, Date.new(2010, 3, 31),  'QQQ', 3)).to eq('Q1')
      expect(@formatter.send(:quarter, Date.new(2010, 4,  1),  'QQQ', 3)).to eq('Q2')
      expect(@formatter.send(:quarter, Date.new(2010, 6, 30),  'QQQ', 3)).to eq('Q2')
      expect(@formatter.send(:quarter, Date.new(2010, 7,  1),  'QQQ', 3)).to eq('Q3')
      expect(@formatter.send(:quarter, Date.new(2010, 9, 30),  'QQQ', 3)).to eq('Q3')
      expect(@formatter.send(:quarter, Date.new(2010, 10,  1), 'QQQ', 3)).to eq('Q4')
      expect(@formatter.send(:quarter, Date.new(2010, 12, 31), 'QQQ', 3)).to eq('Q4')
    end

    it "test: pattern QQQQ" do
      expect(@formatter.send(:quarter, Date.new(2010, 1,  1),  'QQQQ', 4)).to eq('1. Quartal')
      expect(@formatter.send(:quarter, Date.new(2010, 3, 31),  'QQQQ', 4)).to eq('1. Quartal')
      expect(@formatter.send(:quarter, Date.new(2010, 4,  1),  'QQQQ', 4)).to eq('2. Quartal')
      expect(@formatter.send(:quarter, Date.new(2010, 6, 30),  'QQQQ', 4)).to eq('2. Quartal')
      expect(@formatter.send(:quarter, Date.new(2010, 7,  1),  'QQQQ', 4)).to eq('3. Quartal')
      expect(@formatter.send(:quarter, Date.new(2010, 9, 30),  'QQQQ', 4)).to eq('3. Quartal')
      expect(@formatter.send(:quarter, Date.new(2010, 10,  1), 'QQQQ', 4)).to eq('4. Quartal')
      expect(@formatter.send(:quarter, Date.new(2010, 12, 31), 'QQQQ', 4)).to eq('4. Quartal')
    end

    it "test: pattern q" do
      expect(@formatter.send(:quarter, Date.new(2010, 1,  1),  'q', 1)).to eq('1')
      expect(@formatter.send(:quarter, Date.new(2010, 3, 31),  'q', 1)).to eq('1')
      expect(@formatter.send(:quarter, Date.new(2010, 4,  1),  'q', 1)).to eq('2')
      expect(@formatter.send(:quarter, Date.new(2010, 6, 30),  'q', 1)).to eq('2')
      expect(@formatter.send(:quarter, Date.new(2010, 7,  1),  'q', 1)).to eq('3')
      expect(@formatter.send(:quarter, Date.new(2010, 9, 30),  'q', 1)).to eq('3')
      expect(@formatter.send(:quarter, Date.new(2010, 10,  1), 'q', 1)).to eq('4')
      expect(@formatter.send(:quarter, Date.new(2010, 12, 31), 'q', 1)).to eq('4')
    end

    it "test: pattern qq" do
      expect(@formatter.send(:quarter, Date.new(2010, 1,  1),  'qq', 2)).to eq('01')
      expect(@formatter.send(:quarter, Date.new(2010, 3, 31),  'qq', 2)).to eq('01')
      expect(@formatter.send(:quarter, Date.new(2010, 4,  1),  'qq', 2)).to eq('02')
      expect(@formatter.send(:quarter, Date.new(2010, 6, 30),  'qq', 2)).to eq('02')
      expect(@formatter.send(:quarter, Date.new(2010, 7,  1),  'qq', 2)).to eq('03')
      expect(@formatter.send(:quarter, Date.new(2010, 9, 30),  'qq', 2)).to eq('03')
      expect(@formatter.send(:quarter, Date.new(2010, 10,  1), 'qq', 2)).to eq('04')
      expect(@formatter.send(:quarter, Date.new(2010, 12, 31), 'qq', 2)).to eq('04')
    end
  end

  describe "#second" do
    it "test: s" do
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1,  1), 's', 1)).to eq('1')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 11), 's', 1)).to eq('11')
    end

    it "test: ss" do
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1,  1), 'ss', 2)).to eq('01')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 11), 'ss', 2)).to eq('11')
    end

    # have i gotten the spec right here?  (Sven Fuchs)
    it "test: S" do
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 0), 'S', 1)).to eq('0')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 1), 'S', 1)).to eq('1')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 18), 'S', 1)).to eq('18')
    end

    it "test: SS" do
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 0), 'SS', 2)).to eq('00')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 1), 'SS', 2)).to eq('01')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 8), 'SS', 2)).to eq('08')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 21), 'SS', 2)).to eq('21')
    end

    it "test: SSS" do
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 0), 'SSS', 3)).to eq('000')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 1), 'SSS', 3)).to eq('001')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 8), 'SSS', 3)).to eq('008')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 21), 'SSS', 3)).to eq('021')
    end

    it "test: SSSS" do
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 0), 'SSSS', 4)).to eq('0000')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 1), 'SSSS', 4)).to eq('0001')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 8), 'SSSS', 4)).to eq('0008')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 21), 'SSSS', 4)).to eq('0021')
    end

    it "test: SSSSS" do
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 1), 'SSSSS', 5)).to eq('00001')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 8), 'SSSSS', 5)).to eq('00008')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 21), 'SSSSS', 5)).to eq('00021')
    end

    it "test: SSSSSS" do
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 1), 'SSSSSS', 6)).to eq('000001')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 8), 'SSSSSS', 6)).to eq('000008')
      expect(@formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 21), 'SSSSSS', 6)).to eq('000021')
    end
  end

  describe "#timezone" do
    it "test: z, zz, zzz" do # TODO is this what's meant by the spec?
      expect(@formatter.send(:timezone, Time.gm(2000, 1, 1, 1, 1, 1), 'z', 1)).to eq('UTC')
      expect(@formatter.send(:timezone, Time.gm(2000, 1, 1, 1, 1, 1), 'zz', 2)).to eq('UTC')
      expect(@formatter.send(:timezone, Time.gm(2000, 1, 1, 1, 1, 1), 'zzz', 3)).to eq('UTC')
      expect(@formatter.send(:timezone, Time.gm(2000, 1, 1, 1, 1, 1), 'zzzz', 4)).to match(/^UTC (-|\+)\d{2}:\d{2}$/)
    end
  end

  describe "#year" do
    it "test: pattern y" do
      expect(@formatter.send(:year, Date.new(    5, 1, 1), 'y', 1)).to eq('5')
      expect(@formatter.send(:year, Date.new(   45, 1, 1), 'y', 1)).to eq('45')
      expect(@formatter.send(:year, Date.new(  345, 1, 1), 'y', 1)).to eq('345')
      expect(@formatter.send(:year, Date.new( 2345, 1, 1), 'y', 1)).to eq('2345')
      expect(@formatter.send(:year, Date.new(12345, 1, 1), 'y', 1)).to eq('12345')
    end

    it "test: pattern yy" do
      expect(@formatter.send(:year, Date.new(    5, 1, 1), 'yy', 2)).to eq('05')
      expect(@formatter.send(:year, Date.new(   45, 1, 1), 'yy', 2)).to eq('45')
      expect(@formatter.send(:year, Date.new(  345, 1, 1), 'yy', 2)).to eq('45')
      expect(@formatter.send(:year, Date.new( 2345, 1, 1), 'yy', 2)).to eq('45')
      expect(@formatter.send(:year, Date.new(12345, 1, 1), 'yy', 2)).to eq('45')
    end

    it "test: pattern yyy" do
      expect(@formatter.send(:year, Date.new(    5, 1, 1), 'yyy', 3)).to eq('005')
      expect(@formatter.send(:year, Date.new(   45, 1, 1), 'yyy', 3)).to eq('045')
      expect(@formatter.send(:year, Date.new(  345, 1, 1), 'yyy', 3)).to eq('345')
      expect(@formatter.send(:year, Date.new( 2345, 1, 1), 'yyy', 3)).to eq('2345')
      expect(@formatter.send(:year, Date.new(12345, 1, 1), 'yyy', 3)).to eq('12345')
    end

    it "test: pattern yyyy" do
      expect(@formatter.send(:year, Date.new(    5, 1, 1), 'yyyy', 4)).to eq('0005')
      expect(@formatter.send(:year, Date.new(   45, 1, 1), 'yyyy', 4)).to eq('0045')
      expect(@formatter.send(:year, Date.new(  345, 1, 1), 'yyyy', 4)).to eq('0345')
      expect(@formatter.send(:year, Date.new( 2345, 1, 1), 'yyyy', 4)).to eq('2345')
      expect(@formatter.send(:year, Date.new(12345, 1, 1), 'yyyy', 4)).to eq('12345')
    end

    it "test: pattern yyyyy" do
      expect(@formatter.send(:year, Date.new(    5, 1, 1), 'yyyyy', 5)).to eq('00005')
      expect(@formatter.send(:year, Date.new(   45, 1, 1), 'yyyyy', 5)).to eq('00045')
      expect(@formatter.send(:year, Date.new(  345, 1, 1), 'yyyyy', 5)).to eq('00345')
      expect(@formatter.send(:year, Date.new( 2345, 1, 1), 'yyyyy', 5)).to eq('02345')
      expect(@formatter.send(:year, Date.new(12345, 1, 1), 'yyyyy', 5)).to eq('12345')
    end
  end

  describe "#era" do
    before(:each) do
      data_reader = TwitterCldr::DataReaders::DateTimeDataReader.new(:en)
      @formatter = DateTimeFormatter.new(data_reader)
    end

    it "test: pattern G" do
      expect(@formatter.send(:era, Date.new(2012, 1, 1), 'G', 1)).to eq("CE")
      expect(@formatter.send(:era, Date.new(-1, 1, 1), 'G', 1)).to eq("BCE")
    end

    it "test: pattern GG" do
      expect(@formatter.send(:era, Date.new(2012, 1, 1), 'GG', 2)).to eq("CE")
      expect(@formatter.send(:era, Date.new(-1, 1, 1), 'GG', 2)).to eq("BCE")
    end

    it "test: pattern GGG" do
      expect(@formatter.send(:era, Date.new(2012, 1, 1), 'GGG', 3)).to eq("CE")
      expect(@formatter.send(:era, Date.new(-1, 1, 1), 'GGG', 3)).to eq("BCE")
    end

    it "test: pattern GGGG" do
      expect(@formatter.send(:era, Date.new(2012, 1, 1), 'GGGG', 4)).to eq("Common Era")
      expect(@formatter.send(:era, Date.new(-1, 1, 1), 'GGGG', 4)).to eq("Before Common Era")
    end

    it "should fall back if the calendar doesn't contain the appropriate era data" do
      stub(@formatter.data_reader.calendar).eras(:abbr) do
        { 0 => "abbr0", 1 => "abbr1" }
      end

      stub(@formatter.data_reader.calendar).eras(:name) do
        { 0 => "name0" }
      end

      date = Date.new(2012, 1, 1)
      mock.proxy(@formatter).era(date, "GGGG", 4)  # first attempts to find full name era
      mock.proxy(@formatter).era(date, "GGG", 3)   # falls back to abbreviated era
      expect(@formatter.send(:era, date, 'GGGG', 4)).to eq("abbr1")
    end
  end

  describe "#month_stand_alone" do
    it "pattern L" do
      expect(@formatter.send(:month_stand_alone, Date.new(2010,  1,  1), 'L', 1)).to eq("1")
      expect(@formatter.send(:month_stand_alone, Date.new(2010,  10, 1), 'L', 1)).to eq("10")
    end

    it "pattern LL" do
      expect(@formatter.send(:month_stand_alone, Date.new(2010,  1,  1), 'LL', 2)).to eq("01")
      expect(@formatter.send(:month_stand_alone, Date.new(2010,  10, 1), 'LL', 2)).to eq("10")
    end

    it "pattern LLL" do
      expect(@formatter.send(:month_stand_alone, Date.new(2010,  1,  1), 'LLL', 3)).to eq("Jan")
      expect(@formatter.send(:month_stand_alone, Date.new(2010,  10, 1), 'LLL', 3)).to eq("Okt")
    end

    it "pattern LLLL" do
      expect(@formatter.send(:month_stand_alone, Date.new(2010,  1,  1), 'LLLL', 4)).to eq("Januar")
      expect(@formatter.send(:month_stand_alone, Date.new(2010,  10, 1), 'LLLL', 4)).to eq("Oktober")
    end

    it "pattern LLLLL" do
      expect(@formatter.send(:month_stand_alone, Date.new(2010,  1,  1), 'LLLLL', 5)).to eq("J")
      expect(@formatter.send(:month_stand_alone, Date.new(2010,  10, 1), 'LLLLL', 5)).to eq("O")
    end
  end
end