# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

require 'open-uri'

include TwitterCldr::Normalizers

describe 'Unicode Normalization Algorithms' do

  NORMALIZERS_SPEC_PATH = File.dirname(__FILE__)
  SHORT_TEST_PATH       = File.join(NORMALIZERS_SPEC_PATH, 'NormalizationTestShort.txt')
  FULL_TEST_PATH        = File.join(NORMALIZERS_SPEC_PATH, 'NormalizationTest.txt')

  NORMALIZATION_TEST_URL = 'http://unicode.org/Public/UNIDATA/NormalizationTest.txt'

  shared_examples_for 'a normalization algorithm' do
    it 'passes all the tests in NormalizersTestShort.txt' do
      run_short_test(invariants)
    end

    it 'passes all the tests in NormalizersTest.txt', :slow => true do
      run_full_test(invariants)
    end
  end

  describe 'NFD' do
    let(:invariants) {
      lambda do |data|
        NFD.normalize_code_points(data[0]).should == data[2]
        NFD.normalize_code_points(data[1]).should == data[2]
        NFD.normalize_code_points(data[2]).should == data[2]

        NFD.normalize_code_points(data[3]).should == data[4]
        NFD.normalize_code_points(data[4]).should == data[4]
      end
    }

    it_behaves_like 'a normalization algorithm'
  end

  describe 'NFKD' do
    let(:invariants) {
      lambda do |data|
        NFKD.normalize_code_points(data[0]).should == data[4]
        NFKD.normalize_code_points(data[1]).should == data[4]
        NFKD.normalize_code_points(data[2]).should == data[4]
        NFKD.normalize_code_points(data[3]).should == data[4]
        NFKD.normalize_code_points(data[4]).should == data[4]
      end
    }

    it_behaves_like 'a normalization algorithm'
  end

  def run_short_test(invariants)
    open(SHORT_TEST_PATH, 'r:UTF-8') do |file|
      run_normalization_test(file, invariants)
    end
  end

  def run_full_test(invariants)
    prepare_full_test

    open(FULL_TEST_PATH, 'r:UTF-8') do |file|
      run_normalization_test(file, invariants)
    end
  end

  def prepare_full_test
    return if File.file?(FULL_TEST_PATH)

    print '    Downloading NormalizationTest.txt ... '
    open(FULL_TEST_PATH, 'w') { |file| file.write(open(NORMALIZATION_TEST_URL).read) }
    puts 'done.'
  end

  def run_normalization_test(file, invariants)
    file.each do |line|
      next if line.empty? || line =~ /^(@|#)/

      data = line.split(';')[0...5].map { |cps| cps.split }
      invariants.call(data)
    end
  end

end