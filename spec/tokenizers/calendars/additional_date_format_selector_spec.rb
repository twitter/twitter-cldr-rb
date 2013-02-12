# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe AdditionalDateFormatSelector do
  let(:selector) do
    AdditionalDateFormatSelector.new(
      TwitterCldr.get_locale_resource(:en, :calendars)[:en][:calendars][:gregorian][:additional_formats]
    )
  end

  describe "#position_score" do
    it "calculates the score based on relative offset from actual position" do
      goal_entities = selector.send(:separate, "MMMyyd")
      entities      = selector.send(:separate, "d")
      selector.send(:position_score, entities, goal_entities).should == 2
    end

    it "calculates a zero score if all entites are in the same positions" do
      goal_entities = selector.send(:separate, "MMMyyd")
      entities      = selector.send(:separate, "MMMyyd")
      selector.send(:position_score, entities, goal_entities).should == 0
    end
  end

  describe "#exist_score" do
    it "calculates a higher score if an entity doesn't exist" do
      goal_entities = selector.send(:separate, "MMMEd")
      entities      = selector.send(:separate, "d")
      selector.send(:exist_score, entities, goal_entities).should == 2
    end

    it "calculates a zero score if all entities exist" do
      goal_entities = selector.send(:separate, "MMMyyd")
      entities      = selector.send(:separate, "dMMMyy")
      selector.send(:exist_score, entities, goal_entities).should == 0
    end
  end

  describe "#count_score" do
    it "calculates the score based on the difference in the length of each matching entity" do
      goal_entities = selector.send(:separate, "MMMyyd")
      entities      = selector.send(:separate, "ddMMy")
      selector.send(:count_score, entities, goal_entities).should == 3
    end

    it "calculates a zero score if all entities are the same length" do
      goal_entities = selector.send(:separate, "MMMyyd")
      entities      = selector.send(:separate, "d")
      selector.send(:count_score, entities, goal_entities).should == 0
    end
  end

  describe "#score" do
    it "calculates a cumulative score from position and count" do
      goal_entities = selector.send(:separate, "MMMyydGG")
      entities      = selector.send(:separate, "ddMMGGyy")
      selector.send(:exist_score, entities, goal_entities).should == 0
      selector.send(:count_score, entities, goal_entities).should == 2
      selector.send(:position_score, entities, goal_entities).should == 3
      selector.send(:score, entities, goal_entities).should == 5
    end

    it "calculates a cumulative score from position, count, and existence (existence weighted by 2)" do
      goal_entities = selector.send(:separate, "MMMyydGG")
      entities      = selector.send(:separate, "ddMMyy")
      selector.send(:exist_score, entities, goal_entities).should == 1
      selector.send(:count_score, entities, goal_entities).should == 2
      selector.send(:position_score, entities, goal_entities).should == 1
      # (exist_score * 2) + count_score + position_score
      selector.send(:score, entities, goal_entities).should == 5
    end
  end

  describe "#rank" do
    it "returns a score for each available format" do
      ranked_formats = selector.send(:rank, "MMMd")
      ranked_formats["MMMd"].should == 0
      ranked_formats["yMEd"].should == 4
      ranked_formats["y"].should == 4
      ranked_formats["EHms"].should == 4
      ranked_formats["MMM"].should == 2
    end
  end

  describe "#find_closest" do
    it "returns an exact match if it exists" do
      selector.find_closest("MMMd").should == "MMMd"
      selector.find_closest("Hms").should == "Hms"
      selector.find_closest("yQQQQ").should == "yQQQQ"
    end

    it "returns the next closest match (lowest score) if an exact match can't be found" do
      selector.find_closest("MMMMd").should == "MMMd"
      selector.find_closest("mHs").should == "Hms"
      selector.find_closest("Med").should == "MEd"
    end

    it "returns nil if an empty pattern is given" do
      selector.find_closest(nil).should be_nil
      selector.find_closest("").should be_nil
      selector.find_closest(" ").should be_nil
    end
  end

  describe "#separate" do
    it "divides a string into entities by runs of equal characters" do
      selector.send(:separate, "ddMMyy").should == ["dd", "MM", "yy"]
      selector.send(:separate, "ddMMyyMM").should == ["dd", "MM", "yy", "MM"]
      selector.send(:separate, "mmMM").should == ["mm", "MM"]
    end
  end

  describe "#patterns" do
    it "returns a list of all available patterns" do
      patterns = selector.patterns
      patterns.should be_a(Array)
      patterns.should include(:MMMd)
      patterns.should include(:yQQQ)
      patterns.should include(:yQQQQ)
      patterns.should include(:EHms)
      patterns.should include(:d)
    end
  end

end
