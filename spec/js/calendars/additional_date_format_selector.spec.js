// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

var TwitterCldr = require('../../../lib/assets/javascripts/twitter_cldr/en.js');

describe("AdditionalDateFormatSelector", function() {
  beforeEach(function() {
    selector = new TwitterCldr.AdditionalDateFormatSelector(
      TwitterCldr.Calendar.calendar.additional_formats
    )
  });

  describe("#position_score", function() {
    it("calculates the score based on relative offset from actual position", function() {
      var goal_entities = selector.separate("MMMyyd");
      var entities      = selector.separate("d");
      expect(selector.position_score(entities, goal_entities)).toEqual(2);
    });

    it("calculates a zero score if all entites are in the same positions", function() {
      var goal_entities = selector.separate("MMMyyd");
      var entities      = selector.separate("MMMyyd");
      expect(selector.position_score(entities, goal_entities)).toEqual(0);
    });
  });

  describe("#exist_score", function() {
    it("calculates a higher score if an entity doesn't exist", function() {
      var goal_entities = selector.separate("MMMd");
      var entities      = selector.separate("d");
      expect(selector.exist_score(entities, goal_entities)).toEqual(1);
    });

    it("calculates a zero score if all entities exist", function() {
      var goal_entities = selector.separate("MMMyyd");
      var entities      = selector.separate("dMMMyy");
      expect(selector.exist_score(entities, goal_entities)).toEqual(0);
    });
  });

  describe("#count_score", function() {
    it("calculates the score based on the difference in the length of each matching entity", function() {
      var goal_entities = selector.separate("MMMyyd");
      var entities      = selector.separate("ddMMy");
      expect(selector.count_score(entities, goal_entities)).toEqual(3);
    });

    it("calculates a zero score if all entities are the same length", function() {
      var goal_entities = selector.separate("MMMyyd");
      var entities      = selector.separate("d");
      expect(selector.count_score(entities, goal_entities)).toEqual(0);
    });
  });

  describe("#score", function() {
    it("calculates a cumulative score from position and count", function() {
      var goal_entities = selector.separate("MMMyydGG");
      var entities      = selector.separate("ddMMGGyy");
      expect(selector.exist_score(entities, goal_entities)).toEqual(0);
      expect(selector.count_score(entities, goal_entities)).toEqual(2);
      expect(selector.position_score(entities, goal_entities)).toEqual(3);
      expect(selector.score(entities, goal_entities)).toEqual(5);
    });

    it("calculates a cumulative score from position, count, and existence (existence weighted by 2)", function() {
      var goal_entities = selector.separate("MMMyydGG");
      var entities      = selector.separate("ddMMyy");
      expect(selector.exist_score(entities, goal_entities)).toEqual(1);
      expect(selector.count_score(entities, goal_entities)).toEqual(2);
      expect(selector.position_score(entities, goal_entities)).toEqual(1);
      // (exist_score * 2) + count_score + position_score
      expect(selector.score(entities, goal_entities)).toEqual(5);
    });
  });

  describe("#rank", function() {
    it("returns a score for each available format", function() {
      var ranked_formats = selector.rank("MMMd");
      expect(ranked_formats["MMMd"]).toEqual(0);
      expect(ranked_formats["yMEd"]).toEqual(4);
      expect(ranked_formats["y"]).toEqual(4);
      expect(ranked_formats["EHms"]).toEqual(4);
      expect(ranked_formats["MMM"]).toEqual(2);
    });
  });

  describe("#find_closest", function() {
    it("returns an exact match if it exists", function() {
      expect(selector.find_closest("MMMd")).toEqual("MMMd");
      expect(selector.find_closest("Hms")).toEqual("Hms");
      expect(selector.find_closest("yQQQQ")).toEqual("yQQQQ");
    });

    it("returns the next closest match (lowest score) if an exact match can't be found", function() {
      expect(selector.find_closest("MMMMd")).toEqual("MMMd");
      expect(selector.find_closest("mHs")).toEqual("Hms");
      expect(selector.find_closest("Ehds")).toEqual("Ehms");
    });

    it("returns nil if an empty pattern is given", function() {
      expect(selector.find_closest(null)).toBeNull();
      expect(selector.find_closest("")).toBeNull();
      expect(selector.find_closest(" ")).toBeNull();
    });
  });

  describe("#separate", function() {
    it("divides a string into entities by runs of equal characters", function() {
      expect(selector.separate("ddMMyy")).toEqual(["dd", "MM", "yy"]);
      expect(selector.separate("ddMMyyMM")).toEqual(["dd", "MM", "yy", "MM"]);
      expect(selector.separate("mmMM")).toEqual(["mm", "MM"]);
    });
  });

  describe("#patterns", function() {
    it("returns a list of all available patterns", function() {
      var patterns = selector.patterns();
      expect(patterns.constructor.name).toEqual("Array")
      expect(patterns.indexOf("MMMd")).toBeGreaterThan(-1);
      expect(patterns.indexOf("yQQQ")).toBeGreaterThan(-1);
      expect(patterns.indexOf("yQQQQ")).toBeGreaterThan(-1);
      expect(patterns.indexOf("EHms")).toBeGreaterThan(-1);
      expect(patterns.indexOf("d")).toBeGreaterThan(-1);
    });
  });
});