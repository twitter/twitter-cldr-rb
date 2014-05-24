# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::DataReaders

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
      expect(selector.send(:position_score, entities, goal_entities)).to eq(2)
    end

    it "calculates a zero score if all entites are in the same positions" do
      goal_entities = selector.send(:separate, "MMMyyd")
      entities      = selector.send(:separate, "MMMyyd")
      expect(selector.send(:position_score, entities, goal_entities)).to eq(0)
    end
  end

  describe "#exist_score" do
    it "calculates a higher score if an entity doesn't exist" do
      goal_entities = selector.send(:separate, "MMMEd")
      entities      = selector.send(:separate, "d")
      expect(selector.send(:exist_score, entities, goal_entities)).to eq(2)
    end

    it "calculates a zero score if all entities exist" do
      goal_entities = selector.send(:separate, "MMMyyd")
      entities      = selector.send(:separate, "dMMMyy")
      expect(selector.send(:exist_score, entities, goal_entities)).to eq(0)
    end
  end

  describe "#count_score" do
    it "calculates the score based on the difference in the length of each matching entity" do
      goal_entities = selector.send(:separate, "MMMyyd")
      entities      = selector.send(:separate, "ddMMy")
      expect(selector.send(:count_score, entities, goal_entities)).to eq(3)
    end

    it "calculates a zero score if all entities are the same length" do
      goal_entities = selector.send(:separate, "MMMyyd")
      entities      = selector.send(:separate, "d")
      expect(selector.send(:count_score, entities, goal_entities)).to eq(0)
    end
  end

  describe "#score" do
    it "calculates a cumulative score from position and count" do
      goal_entities = selector.send(:separate, "MMMyydGG")
      entities      = selector.send(:separate, "ddMMGGyy")
      expect(selector.send(:exist_score, entities, goal_entities)).to eq(0)
      expect(selector.send(:count_score, entities, goal_entities)).to eq(2)
      expect(selector.send(:position_score, entities, goal_entities)).to eq(3)
      expect(selector.send(:score, entities, goal_entities)).to eq(5)
    end

    it "calculates a cumulative score from position, count, and existence (existence weighted by 2)" do
      goal_entities = selector.send(:separate, "MMMyydGG")
      entities      = selector.send(:separate, "ddMMyy")
      expect(selector.send(:exist_score, entities, goal_entities)).to eq(1)
      expect(selector.send(:count_score, entities, goal_entities)).to eq(2)
      expect(selector.send(:position_score, entities, goal_entities)).to eq(1)
      # (exist_score * 2) + count_score + position_score
      expect(selector.send(:score, entities, goal_entities)).to eq(5)
    end
  end

  describe "#rank" do
    it "returns a score for each available format" do
      ranked_formats = selector.send(:rank, "MMMd")
      expect(ranked_formats["MMMd"]).to eq(0)
      expect(ranked_formats["yMEd"]).to eq(4)
      expect(ranked_formats["y"]).to eq(4)
      expect(ranked_formats["EHms"]).to eq(4)
      expect(ranked_formats["MMM"]).to eq(2)
    end
  end

  describe "#find_closest" do
    it "returns an exact match if it exists" do
      expect(selector.find_closest("h")).to eq(selector.pattern_hash[:h])
      expect(selector.find_closest("MMMd")).to eq(selector.pattern_hash[:MMMd])
      expect(selector.find_closest("Hms")).to eq(selector.pattern_hash[:Hms])
      expect(selector.find_closest("yQQQQ")).to eq(selector.pattern_hash[:yQQQQ])
    end

    it "returns the next closest match (lowest score) if an exact match can't be found" do
      expect(selector.find_closest("MMMMd")).to eq(selector.pattern_hash[:MMMd])
      expect(selector.find_closest("mHs")).to eq(selector.pattern_hash[:Hms])
      expect(selector.find_closest("Med")).to eq(selector.pattern_hash[:MEd])
    end

    it "returns nil if an empty pattern is given" do
      expect(selector.find_closest(nil)).to be_nil
      expect(selector.find_closest("")).to be_nil
      expect(selector.find_closest(" ")).to be_nil
    end
  end

  describe "#separate" do
    it "divides a string into entities by runs of equal characters" do
      expect(selector.send(:separate, "ddMMyy")).to eq(["dd", "MM", "yy"])
      expect(selector.send(:separate, "ddMMyyMM")).to eq(["dd", "MM", "yy", "MM"])
      expect(selector.send(:separate, "mmMM")).to eq(["mm", "MM"])
    end
  end

  describe "#patterns" do
    it "returns a list of all available patterns" do
      patterns = selector.patterns
      expect(patterns).to be_a(Array)
      expect(patterns).to include("MMMd")
      expect(patterns).to include("yQQQ")
      expect(patterns).to include("yQQQQ")
      expect(patterns).to include("EHms")
      expect(patterns).to include("d")
    end
  end

end
