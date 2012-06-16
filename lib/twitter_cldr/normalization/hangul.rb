# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalization
    module Hangul

      class << self

        # Special composition for Hangul syllables. Documented in Section 3.12 at
        # http://www.unicode.org/versions/Unicode6.1.0/ch03.pdf
        #
        def compose(code_points)
          l = code_points.first - LBASE
          v = code_points[1] - VBASE
          t = code_points[2] ? code_points[2] - TBASE : 0  # T part may be missing, that's ok

          SBASE + l * NCOUNT + v * TCOUNT + t
        end

        # Special decomposition for Hangul syllables. Documented in Section 3.12 at http://www.unicode.org/versions/Unicode6.1.0/ch03.pdf
        # Also see http://source.icu-project.org/repos/icu/icuhtml/trunk/design/collation/ICU_collation_design.htm#Hangul_Implicit_CEs
        #
        def decompose(code_point)
          l = code_point - SBASE

          t = l % TCOUNT
          l /= TCOUNT
          v = l % VCOUNT
          l /= VCOUNT

          result = []

          result << LBASE + l
          result << VBASE + v
          result << TBASE + t if t > 0

          result
        end

        def hangul_syllable?(code_point)
          (SBASE...SLIMIT).include?(code_point)
        end

        SBASE  = 0xAC00
        LBASE  = 0x1100
        VBASE  = 0x1161
        TBASE  = 0x11A7

        LCOUNT = 19
        VCOUNT = 21
        TCOUNT = 28

        NCOUNT = VCOUNT * TCOUNT # 588
        SCOUNT = LCOUNT * NCOUNT # 11172

        LLIMIT = LBASE + LCOUNT  # 0x1113 = 4371
        VLIMIT = VBASE + VCOUNT  # 0x1176 = 4470
        TLIMIT = TBASE + TCOUNT  # 0x11C3 = 4547
        SLIMIT = SBASE + SCOUNT  # 0xD7A4 = 55204

      end

    end
  end
end
