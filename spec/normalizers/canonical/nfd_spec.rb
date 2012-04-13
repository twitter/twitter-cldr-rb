# encoding: UTF-8

require 'spec_helper'

include TwitterCldr::Normalizers

describe NFD do
	describe "#decompose_code_point" do
		it "does not decompose a character with no decomposition mapping" do
			code_points = ["0EB8", "041F", "0066", "1F52C", "A2D6"]
			code_points.each do |code_point|
				NFD.decompose_code_point(code_point).should == code_point
			end
		end

		it "does not decompose a character with compatibility decomposition mapping" do
			code_points = ["A770", "FB02", "FC35", "FD20", "00BC"]
			code_points.each do |code_point|				
				NFD.decompose_code_point(code_point).should == code_point
			end
		end
	end

	describe "#normalize" do
		it "passes all the tests in NormalizersTest.txt" do
			Encoding.default_external = Encoding::UTF_8
			normalization_test_file = File.join(File.dirname(File.dirname(__FILE__)), "NormalizationTest.txt")
			lines = IO.readlines(normalization_test_file).each do |line|
				unless line =~ /(HANGUL|KOREAN)/ or line[0] =~ /(@|#)/ or line.empty?
					c1, c2, c3, c4, c5 = line.split(';')[0...5].map { |cps| cps.split }					
					#puts c1.inspect
					NFD.normalize_code_points(c1).should == c3
					NFD.normalize_code_points(c2).should == c3
					NFD.normalize_code_points(c3).should == c3
					NFD.normalize_code_points(c4).should == c5
					NFD.normalize_code_points(c5).should == c5
				end
			end
		end
	end
end