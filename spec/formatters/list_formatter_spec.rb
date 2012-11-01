# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe ListFormatter do
  describe '#initialize' do
    it 'fetches locale from options hash' do
      ListFormatter.new(:locale => :pt).locale.should == :pt
    end

    it "uses default locale if it's not passed in options hash" do
      ListFormatter.new.locale.should == TwitterCldr::DEFAULT_LOCALE
    end
  end

  context "with an initialized list formatter" do
    before(:each) do
      @formatter = ListFormatter.new
    end

    describe "#compose" do
      it "should reorder rtl lists" do
        list = ["larry", "curly"]
        @formatter.locale = :ar
        @formatter.send(:compose, "{0} \331\210 {1}", list).should == "curly \331\210 larry"
      end

      it "should format a variable number of elements correctly" do
        list = ["larry", "curly", "moe"]
        @formatter.send(:compose, "{0} - {1} - {2}", list).should == "larry - curly - moe"
        @formatter.send(:compose, "{0} - {1}", list).should == "larry - curly"
        @formatter.send(:compose, "{0}", list).should == "larry"
        @formatter.send(:compose, "", list).should == ""
      end

      it "should return the first element if the list only contains a single element" do
        @formatter.send(:compose, "{0} - {1}", ["larry"]).should == "larry"
      end

      it "should return an empty string if the list is empty" do
        @formatter.send(:compose, "{0} - {1}", []).should == ""
      end
    end

    context "with a standard resource" do
      before(:each) do
        stub(@formatter).resource do
          {
            2       => "{0} $ {1}",
            :middle => "{0}; {1}",
            :start  => "{0}< {1}",
            :end    => "{0}> {1}"
          }
        end
      end

      describe "#compose_list" do
        it "should compose a list with two elements using the :end format" do
          @formatter.send(:compose_list, ["larry", "curly"]).should == "larry> curly"
        end

        it "should compose a list with three elements using the :start and :end formats" do
          @formatter.send(:compose_list, ["larry", "curly", "moe"]).should == "larry< curly> moe"
        end

        it "should compose a list with four elements using all the formats (:start, :middle, and :end)" do
          @formatter.send(:compose_list, ["larry", "curly", "moe", "jerry"]).should == "larry< curly; moe> jerry"
        end

        it "should compose a list of five elements just for the hell of it" do
          @formatter.send(:compose_list, ["larry", "curly", "moe", "jerry", "helga"]).should == "larry< curly; moe; jerry> helga"
        end
      end

      describe "#format" do
        it "should format correctly using the integer index if it exists" do
          @formatter.format(["larry", "curly"]).should == "larry $ curly"
        end

        it "should format correctly if no corresponding integer index exists" do
          @formatter.format(["larry", "curly", "moe"]).should == "larry< curly> moe"
        end
      end
    end

    context "with a resource that doesn't contain a start or end" do
      before(:each) do
        stub(@formatter).resource do
          { :middle => "{0}; {1}" }
        end
      end

      describe "#compose_list" do
        it "should correctly compose a list with four elements, falling back to :middle for the beginning and end" do
          @formatter.send(:compose_list, ["larry", "curly", "moe", "jerry"]).should == "larry; curly; moe; jerry"
        end
      end
    end

    context "with an empty resource" do
      before(:each) do
        stub(@formatter).resource do
          {}
        end
      end

      describe "#compose_list" do
        it "should return a blank string since no formats are available" do
          @formatter.send(:compose_list, ["larry", "curly", "moe"]).should == ""
        end
      end
    end
  end
end