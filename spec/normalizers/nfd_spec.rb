# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

require 'open-uri'

include TwitterCldr::Normalizers

describe NFD do

  NORMALIZERS_SPEC_PATH = File.dirname(__FILE__)

  NORMALIZATION_TEST_URL = 'http://unicode.org/Public/UNIDATA/NormalizationTest.txt'

  describe "#normalize" do
    NFD.normalize("庠摪饢鼢豦樄澸脧鱵礩翜艰").should == "庠摪饢鼢豦樄澸脧鱵礩翜艰"
    NFD.normalize("䷙䷿").should == "䷙䷿"
    NFD.normalize("ᎿᎲᎪᏨᎨᏪᎧᎵᏥ").should == "ᎿᎲᎪᏨᎨᏪᎧᎵᏥ"
    NFD.normalize("ᆙᅓᆼᄋᇶ").should == "ᆙᅓᆼᄋᇶ"
    NFD.normalize("…‾⁋ ⁒⁯‒′‾⁖").should == "…‾⁋ ⁒⁯‒′‾⁖"
    NFD.normalize("ⶾⷕⶱⷀ").should == "ⶾⷕⶱⷀ"
  end

  describe "#normalize_code_points" do
    it "passes all the tests in NormalizersTestShort.txt" do
      open(File.join(NORMALIZERS_SPEC_PATH, 'NormalizationTestShort.txt'), 'r:UTF-8') do |file|
        run_normalization_test(file)
      end
    end

    it "passes all the tests in NormalizersTest.txt", :slow => true do
      file_path = File.join(NORMALIZERS_SPEC_PATH, 'NormalizationTest.txt')

      unless File.file?(file_path)
        print '    Downloading NormalizationTest.txt ... '
        open(file_path, 'w') { |file| file.write(open(NORMALIZATION_TEST_URL).read) }
        puts 'done.'
      end

      open(file_path, 'r:UTF-8') do |file|
        run_normalization_test(file)
      end
    end
  end

  def run_normalization_test(file)
    file.each do |line|
      next if line[0,1] =~ /(@|#)/ || line.empty?

      c1, c2, c3, c4, c5 = line.split(';')[0...5].map { |cps| cps.split }

      NFD.normalize_code_points(c1).should == c3
      NFD.normalize_code_points(c2).should == c3
      NFD.normalize_code_points(c3).should == c3
      NFD.normalize_code_points(c4).should == c5
      NFD.normalize_code_points(c5).should == c5
    end
  end

end