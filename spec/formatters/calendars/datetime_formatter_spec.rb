# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe DateTimeFormatter do
  before(:each) do
    @formatter = DateTimeFormatter.new(:locale => :de)
  end

  describe "#day" do
    it "test: pattern d" do
      @formatter.send(:day, Date.new(2010, 1,  1), 'd', 1).should == '1'
      @formatter.send(:day, Date.new(2010, 1, 10), 'd', 1).should == '10'
    end

    it "test: pattern dd" do
      @formatter.send(:day, Date.new(2010, 1,  1), 'dd', 2).should == '01'
      @formatter.send(:day, Date.new(2010, 1, 10), 'dd', 2).should == '10'
    end
  end

  describe "#weekday_local_stand_alone" do
    it "test: pattern c" do
      @formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,   4), 'c', 1).should == '1'
      @formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,   5), 'c', 1).should == '2'
      @formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,  10), 'c', 1).should == '7'
    end

    it "test: pattern cc" do
      @formatter.send(:weekday_local_stand_alone, Date.new(2010, 1, 4),  'cc',  2).should == 'Mo.'
      @formatter.send(:weekday_local_stand_alone, Date.new(2010, 1, 5),  'cc',  2).should == 'Di.'
      @formatter.send(:weekday_local_stand_alone, Date.new(2010, 1, 10), 'cc',  2).should == 'So.'
    end

    it "test: pattern ccc" do
      @formatter.send(:weekday_local_stand_alone, Date.new(2010, 1, 4),  'ccc',  3).should == 'Mo.'
      @formatter.send(:weekday_local_stand_alone, Date.new(2010, 1, 5),  'ccc',  3).should == 'Di.'
      @formatter.send(:weekday_local_stand_alone, Date.new(2010, 1, 10), 'ccc',  3).should == 'So.'
    end

    it "test: pattern cccc" do
      @formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,   4), 'cccc', 4).should == 'Montag'
      @formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,   5), 'cccc', 4).should == 'Dienstag'
      @formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,  10), 'cccc', 4).should == 'Sonntag'
    end

    it "test: pattern ccccc" do
      @formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,   4), 'ccccc', 5).should == 'M'
      @formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,   5), 'ccccc', 5).should == 'D'
      @formatter.send(:weekday_local_stand_alone, Date.new(2010, 1,  10), 'ccccc', 5).should == 'S'
    end
  end

  describe "#weekday_local" do
    it "test: pattern e" do
      @formatter.send(:weekday_local, Date.new(2010, 1,   4), 'e', 1).should == '1'
      @formatter.send(:weekday_local, Date.new(2010, 1,   5), 'e', 1).should == '2'
      @formatter.send(:weekday_local, Date.new(2010, 1,  10), 'e', 1).should == '7'
    end

    it "test: pattern ee" do
      @formatter.send(:weekday_local, Date.new(2010, 1,   4), 'ee', 2).should == '1'
      @formatter.send(:weekday_local, Date.new(2010, 1,   5), 'ee', 2).should == '2'
      @formatter.send(:weekday_local, Date.new(2010, 1,  10), 'ee', 2).should == '7'
    end

    it "test: pattern eee" do
      @formatter.send(:weekday_local, Date.new(2010, 1,   4), 'eee', 3).should == 'Mo.'
      @formatter.send(:weekday_local, Date.new(2010, 1,   5), 'eee', 3).should == 'Di.'
      @formatter.send(:weekday_local, Date.new(2010, 1,  10), 'eee', 3).should == 'So.'
    end

    it "test: pattern eeee" do
      @formatter.send(:weekday_local, Date.new(2010, 1,   4), 'eeee', 4).should == 'Montag'
      @formatter.send(:weekday_local, Date.new(2010, 1,   5), 'eeee', 4).should == 'Dienstag'
      @formatter.send(:weekday_local, Date.new(2010, 1,  10), 'eeee', 4).should == 'Sonntag'
    end

    it "test: pattern eeeee" do
      @formatter.send(:weekday_local, Date.new(2010, 1,   4), 'eeeee', 5).should == 'M'
      @formatter.send(:weekday_local, Date.new(2010, 1,   5), 'eeeee', 5).should == 'D'
      @formatter.send(:weekday_local, Date.new(2010, 1,  10), 'eeeee', 5).should == 'S'
    end
  end

  describe "#weekday" do
    it "test: pattern E, EE, EEE" do
      @formatter.send(:weekday, Date.new(2010, 1, 1), 'E',   1).should == 'Fr.'
      @formatter.send(:weekday, Date.new(2010, 1, 1), 'EE',  2).should == 'Fr.'
      @formatter.send(:weekday, Date.new(2010, 1, 1), 'EEE', 3).should == 'Fr.'
    end

    it "test: pattern EEEE" do
      @formatter.send(:weekday, Date.new(2010, 1, 1), 'EEEE', 4).should == 'Freitag'
    end

    it "test: pattern EEEEE" do
      @formatter.send(:weekday, Date.new(2010, 1, 1), 'EEEEE', 5).should == 'F'
    end
  end

  describe "#hour" do
    it "test: h" do
      @formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'h', 1).should == '12'
      @formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'h', 1).should == '1'
      @formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'h', 1).should == '11'
      @formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'h', 1).should == '12'
      @formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'h', 1).should == '11'
    end

    it "test: hh" do
      @formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'hh', 2).should == '12'
      @formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'hh', 2).should == '01'
      @formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'hh', 2).should == '11'
      @formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'hh', 2).should == '12'
      @formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'hh', 2).should == '11'
    end

    it "test: H" do
      @formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'H', 1).should == '0'
      @formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'H', 1).should == '1'
      @formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'H', 1).should == '11'
      @formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'H', 1).should == '12'
      @formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'H', 1).should == '23'
    end

    it "test: HH" do
      @formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'HH', 2).should == '00'
      @formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'HH', 2).should == '01'
      @formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'HH', 2).should == '11'
      @formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'HH', 2).should == '12'
      @formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'HH', 2).should == '23'
    end

    it "test: K" do
      @formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'K', 1).should == '0'
      @formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'K', 1).should == '1'
      @formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'K', 1).should == '11'
      @formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'K', 1).should == '0'
      @formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'K', 1).should == '11'
    end

    it "test: KK" do
      @formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'KK', 2).should == '00'
      @formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'KK', 2).should == '01'
      @formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'KK', 2).should == '11'
      @formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'KK', 2).should == '00'
      @formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'KK', 2).should == '11'
    end

    it "test: k" do
      @formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'k', 1).should == '24'
      @formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'k', 1).should == '1'
      @formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'k', 1).should == '11'
      @formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'k', 1).should == '12'
      @formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'k', 1).should == '23'
    end

    it "test: kk" do
      @formatter.send(:hour, Time.local(2000, 1, 1,  0, 1, 1), 'kk', 2).should == '24'
      @formatter.send(:hour, Time.local(2000, 1, 1,  1, 1, 1), 'kk', 2).should == '01'
      @formatter.send(:hour, Time.local(2000, 1, 1, 11, 1, 1), 'kk', 2).should == '11'
      @formatter.send(:hour, Time.local(2000, 1, 1, 12, 1, 1), 'kk', 2).should == '12'
      @formatter.send(:hour, Time.local(2000, 1, 1, 23, 1, 1), 'kk', 2).should == '23'
    end
  end

  describe "#minute" do
    it "test: m" do
      @formatter.send(:minute, Time.local(2000, 1, 1, 1,  1, 1), 'm', 1).should == '1'
      @formatter.send(:minute, Time.local(2000, 1, 1, 1, 11, 1), 'm', 1).should == '11'
    end

    it "test: mm" do
      @formatter.send(:minute, Time.local(2000, 1, 1, 1,  1, 1), 'mm', 2).should == '01'
      @formatter.send(:minute, Time.local(2000, 1, 1, 1, 11, 1), 'mm', 2).should == '11'
    end
  end

  describe "#month" do
    it "test: pattern M" do
      @formatter.send(:month, Date.new(2010,  1, 1), 'M', 1).should == '1'
      @formatter.send(:month, Date.new(2010, 10, 1), 'M', 1).should == '10'
    end

    it "test: pattern MM" do
      @formatter.send(:month, Date.new(2010,  1, 1), 'MM', 2).should == '01'
      @formatter.send(:month, Date.new(2010, 10, 1), 'MM', 2).should == '10'
    end

    it "test: pattern MMM" do
      @formatter.send(:month, Date.new(2010,  1, 1), 'MMM', 3).should == 'Jan'
      @formatter.send(:month, Date.new(2010, 10, 1), 'MMM', 3).should == 'Okt'
    end

    it "test: pattern MMMM" do
      @formatter.send(:month, Date.new(2010,  1, 1), 'MMMM', 4).should == 'Januar'
      @formatter.send(:month, Date.new(2010, 10, 1), 'MMMM', 4).should == 'Oktober'
    end

    it "test: pattern L" do
      @formatter.send(:month, Date.new(2010,  1, 1), 'L', 1).should == '1'
      @formatter.send(:month, Date.new(2010, 10, 1), 'L', 1).should == '10'
    end

    it "test: pattern LL" do
      @formatter.send(:month, Date.new(2010,  1, 1), 'LL', 2).should == '01'
      @formatter.send(:month, Date.new(2010, 10, 1), 'LL', 2).should == '10'
    end
  end

  describe "#period" do
    it "test: a" do
      @formatter.send(:period, Time.local(2000, 1, 1, 1, 1, 1), 'a', 1).should == 'vorm.'
      @formatter.send(:period, Time.local(2000, 1, 1, 15, 1, 1), 'a', 1).should == 'nachm.'
    end
  end

  describe "#quarter" do
    it "test: pattern Q" do
      @formatter.send(:quarter, Date.new(2010, 1,  1),  'Q', 1).should == '1'
      @formatter.send(:quarter, Date.new(2010, 3, 31),  'Q', 1).should == '1'
      @formatter.send(:quarter, Date.new(2010, 4,  1),  'Q', 1).should == '2'
      @formatter.send(:quarter, Date.new(2010, 6, 30),  'Q', 1).should == '2'
      @formatter.send(:quarter, Date.new(2010, 7,  1),  'Q', 1).should == '3'
      @formatter.send(:quarter, Date.new(2010, 9, 30),  'Q', 1).should == '3'
      @formatter.send(:quarter, Date.new(2010, 10,  1), 'Q', 1).should == '4'
      @formatter.send(:quarter, Date.new(2010, 12, 31), 'Q', 1).should == '4'
    end

    it "test: pattern QQ" do
      @formatter.send(:quarter, Date.new(2010, 1,  1),  'QQ', 2).should == '01'
      @formatter.send(:quarter, Date.new(2010, 3, 31),  'QQ', 2).should == '01'
      @formatter.send(:quarter, Date.new(2010, 4,  1),  'QQ', 2).should == '02'
      @formatter.send(:quarter, Date.new(2010, 6, 30),  'QQ', 2).should == '02'
      @formatter.send(:quarter, Date.new(2010, 7,  1),  'QQ', 2).should == '03'
      @formatter.send(:quarter, Date.new(2010, 9, 30),  'QQ', 2).should == '03'
      @formatter.send(:quarter, Date.new(2010, 10,  1), 'QQ', 2).should == '04'
      @formatter.send(:quarter, Date.new(2010, 12, 31), 'QQ', 2).should == '04'
    end

    it "test: pattern QQQ" do
      @formatter.send(:quarter, Date.new(2010, 1,  1),  'QQQ', 3).should == 'Q1'
      @formatter.send(:quarter, Date.new(2010, 3, 31),  'QQQ', 3).should == 'Q1'
      @formatter.send(:quarter, Date.new(2010, 4,  1),  'QQQ', 3).should == 'Q2'
      @formatter.send(:quarter, Date.new(2010, 6, 30),  'QQQ', 3).should == 'Q2'
      @formatter.send(:quarter, Date.new(2010, 7,  1),  'QQQ', 3).should == 'Q3'
      @formatter.send(:quarter, Date.new(2010, 9, 30),  'QQQ', 3).should == 'Q3'
      @formatter.send(:quarter, Date.new(2010, 10,  1), 'QQQ', 3).should == 'Q4'
      @formatter.send(:quarter, Date.new(2010, 12, 31), 'QQQ', 3).should == 'Q4'
    end

    it "test: pattern QQQQ" do
      @formatter.send(:quarter, Date.new(2010, 1,  1),  'QQQQ', 4).should == '1. Quartal'
      @formatter.send(:quarter, Date.new(2010, 3, 31),  'QQQQ', 4).should == '1. Quartal'
      @formatter.send(:quarter, Date.new(2010, 4,  1),  'QQQQ', 4).should == '2. Quartal'
      @formatter.send(:quarter, Date.new(2010, 6, 30),  'QQQQ', 4).should == '2. Quartal'
      @formatter.send(:quarter, Date.new(2010, 7,  1),  'QQQQ', 4).should == '3. Quartal'
      @formatter.send(:quarter, Date.new(2010, 9, 30),  'QQQQ', 4).should == '3. Quartal'
      @formatter.send(:quarter, Date.new(2010, 10,  1), 'QQQQ', 4).should == '4. Quartal'
      @formatter.send(:quarter, Date.new(2010, 12, 31), 'QQQQ', 4).should == '4. Quartal'
    end

    it "test: pattern q" do
      @formatter.send(:quarter, Date.new(2010, 1,  1),  'q', 1).should == '1'
      @formatter.send(:quarter, Date.new(2010, 3, 31),  'q', 1).should == '1'
      @formatter.send(:quarter, Date.new(2010, 4,  1),  'q', 1).should == '2'
      @formatter.send(:quarter, Date.new(2010, 6, 30),  'q', 1).should == '2'
      @formatter.send(:quarter, Date.new(2010, 7,  1),  'q', 1).should == '3'
      @formatter.send(:quarter, Date.new(2010, 9, 30),  'q', 1).should == '3'
      @formatter.send(:quarter, Date.new(2010, 10,  1), 'q', 1).should == '4'
      @formatter.send(:quarter, Date.new(2010, 12, 31), 'q', 1).should == '4'
    end

    it "test: pattern qq" do
      @formatter.send(:quarter, Date.new(2010, 1,  1),  'qq', 2).should == '01'
      @formatter.send(:quarter, Date.new(2010, 3, 31),  'qq', 2).should == '01'
      @formatter.send(:quarter, Date.new(2010, 4,  1),  'qq', 2).should == '02'
      @formatter.send(:quarter, Date.new(2010, 6, 30),  'qq', 2).should == '02'
      @formatter.send(:quarter, Date.new(2010, 7,  1),  'qq', 2).should == '03'
      @formatter.send(:quarter, Date.new(2010, 9, 30),  'qq', 2).should == '03'
      @formatter.send(:quarter, Date.new(2010, 10,  1), 'qq', 2).should == '04'
      @formatter.send(:quarter, Date.new(2010, 12, 31), 'qq', 2).should == '04'
    end
  end

  describe "#second" do
    it "test: s" do
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1,  1), 's', 1).should == '1'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 11), 's', 1).should == '11'
    end

    it "test: ss" do
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1,  1), 'ss', 2).should == '01'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 11), 'ss', 2).should == '11'
    end

    # have i gotten the spec right here?  (Sven Fuchs)
    it "test: S" do
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 0), 'S', 1).should == '0'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 1), 'S', 1).should == '1'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 18), 'S', 1).should == '18'
    end

    it "test: SS" do
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 0), 'SS', 2).should == '00'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 1), 'SS', 2).should == '01'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 8), 'SS', 2).should == '08'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 21), 'SS', 2).should == '21'
    end

    it "test: SSS" do
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 0), 'SSS', 3).should == '000'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 1), 'SSS', 3).should == '001'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 8), 'SSS', 3).should == '008'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 21), 'SSS', 3).should == '021'
    end

    it "test: SSSS" do
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 0), 'SSSS', 4).should == '0000'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 1), 'SSSS', 4).should == '0001'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 8), 'SSSS', 4).should == '0008'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 21), 'SSSS', 4).should == '0021'
    end

    it "test: SSSSS" do
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 1), 'SSSSS', 5).should == '00001'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 8), 'SSSSS', 5).should == '00008'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 21), 'SSSSS', 5).should == '00021'
    end

    it "test: SSSSSS" do
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 1), 'SSSSSS', 6).should == '000001'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 8), 'SSSSSS', 6).should == '000008'
      @formatter.send(:second, Time.local(2000, 1, 1, 1, 1, 21), 'SSSSSS', 6).should == '000021'
    end
  end

  describe "#timezone" do
    it "test: z, zz, zzz" do # TODO is this what's meant by the spec?
      @formatter.send(:timezone, Time.gm(2000, 1, 1, 1, 1, 1), 'z', 1).should == 'UTC'
      @formatter.send(:timezone, Time.gm(2000, 1, 1, 1, 1, 1), 'zz', 2).should == 'UTC'
      @formatter.send(:timezone, Time.gm(2000, 1, 1, 1, 1, 1), 'zzz', 3).should == 'UTC'
      @formatter.send(:timezone, Time.gm(2000, 1, 1, 1, 1, 1), 'zzzz', 4).should =~ /^UTC (-|\+)\d{4}$/
    end
  end

  describe "#year" do
    it "test: pattern y" do
      @formatter.send(:year, Date.new(    5, 1, 1), 'y', 1).should == '5'
      @formatter.send(:year, Date.new(   45, 1, 1), 'y', 1).should == '45'
      @formatter.send(:year, Date.new(  345, 1, 1), 'y', 1).should == '345'
      @formatter.send(:year, Date.new( 2345, 1, 1), 'y', 1).should == '2345'
      @formatter.send(:year, Date.new(12345, 1, 1), 'y', 1).should == '12345'
    end

    it "test: pattern yy" do
      @formatter.send(:year, Date.new(    5, 1, 1), 'yy', 2).should == '05'
      @formatter.send(:year, Date.new(   45, 1, 1), 'yy', 2).should == '45'
      @formatter.send(:year, Date.new(  345, 1, 1), 'yy', 2).should == '45'
      @formatter.send(:year, Date.new( 2345, 1, 1), 'yy', 2).should == '45'
      @formatter.send(:year, Date.new(12345, 1, 1), 'yy', 2).should == '45'
    end

    it "test: pattern yyy" do
      @formatter.send(:year, Date.new(    5, 1, 1), 'yyy', 3).should == '005'
      @formatter.send(:year, Date.new(   45, 1, 1), 'yyy', 3).should == '045'
      @formatter.send(:year, Date.new(  345, 1, 1), 'yyy', 3).should == '345'
      @formatter.send(:year, Date.new( 2345, 1, 1), 'yyy', 3).should == '2345'
      @formatter.send(:year, Date.new(12345, 1, 1), 'yyy', 3).should == '12345'
    end

    it "test: pattern yyyy" do
      @formatter.send(:year, Date.new(    5, 1, 1), 'yyyy', 4).should == '0005'
      @formatter.send(:year, Date.new(   45, 1, 1), 'yyyy', 4).should == '0045'
      @formatter.send(:year, Date.new(  345, 1, 1), 'yyyy', 4).should == '0345'
      @formatter.send(:year, Date.new( 2345, 1, 1), 'yyyy', 4).should == '2345'
      @formatter.send(:year, Date.new(12345, 1, 1), 'yyyy', 4).should == '12345'
    end

    it "test: pattern yyyyy" do
      @formatter.send(:year, Date.new(    5, 1, 1), 'yyyyy', 5).should == '00005'
      @formatter.send(:year, Date.new(   45, 1, 1), 'yyyyy', 5).should == '00045'
      @formatter.send(:year, Date.new(  345, 1, 1), 'yyyyy', 5).should == '00345'
      @formatter.send(:year, Date.new( 2345, 1, 1), 'yyyyy', 5).should == '02345'
      @formatter.send(:year, Date.new(12345, 1, 1), 'yyyyy', 5).should == '12345'
    end
  end

  describe "#era" do
    before(:each) do
      @formatter = DateTimeFormatter.new(:locale => :en)
    end

    it "test: pattern G" do
      @formatter.send(:era, Date.new(2012, 1, 1), 'G', 1).should == "AD"
      @formatter.send(:era, Date.new(-1, 1, 1), 'G', 1).should == "BC"
    end

    it "test: pattern GG" do
      @formatter.send(:era, Date.new(2012, 1, 1), 'GG', 2).should == "AD"
      @formatter.send(:era, Date.new(-1, 1, 1), 'GG', 2).should == "BC"
    end

    it "test: pattern GGG" do
      @formatter.send(:era, Date.new(2012, 1, 1), 'GGG', 3).should == "AD"
      @formatter.send(:era, Date.new(-1, 1, 1), 'GGG', 3).should == "BC"
    end

    it "test: pattern GGGG" do
      @formatter.send(:era, Date.new(2012, 1, 1), 'GGGG', 4).should == "Anno Domini"
      @formatter.send(:era, Date.new(-1, 1, 1), 'GGGG', 4).should == "Before Christ"
    end
  end
end