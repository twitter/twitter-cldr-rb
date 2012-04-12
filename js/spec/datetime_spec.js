//= require '../build/twitter_cldr_en.js'

describe("DateTimeFormatter", function() {
	beforeEach(function() {
		//date = new Date(Date.parse("Mon Apr 09 2012 13:13:53 GMT-0700 (PDT)"));
		formatter = new TwitterCldr.Formatters.DateTimeFormatter();
	});

	describe("#day", function() {
		it("test: pattern d", function() {
			expect(formatter.day(new Date(2010, 0,  1), 'd', 1)).toEqual('1');
			expect(formatter.day(new Date(2010, 0, 10), 'd', 1)).toEqual('10');
		});

		it("test: pattern dd", function() {
			expect(formatter.day(new Date(2010, 0,  1), 'dd', 2)).toEqual('01');
			expect(formatter.day(new Date(2010, 0, 10), 'dd', 2)).toEqual('10');
		});
	});

	describe("#weekday", function() {
	  it("test: pattern E, EE, EEE", function() {
	    expect(formatter.weekday(new Date(2010, 0, 1), 'E', 1)).toEqual('Fri');
	    expect(formatter.weekday(new Date(2010, 0, 1), 'EE', 2)).toEqual('Fri');
	    expect(formatter.weekday(new Date(2010, 0, 1), 'EEE', 3)).toEqual('Fri');
	  });

	  it("test: pattern EEEE", function() {
	    expect(formatter.weekday(new Date(2010, 0, 1), 'EEEE', 4)).toEqual('Friday');
	  });

	  it("test: pattern EEEEE", function() {
	    expect(formatter.weekday(new Date(2010, 0, 1), 'EEEEE', 5)).toEqual('F');
	  });
	});

  describe("#hour", function() {
    it("test: h", function() {
      expect(formatter.hour(new Date(2000, 0, 1,  0, 1, 1), 'h', 1)).toEqual('12');
      expect(formatter.hour(new Date(2000, 0, 1,  1, 1, 1), 'h', 1)).toEqual('1');
      expect(formatter.hour(new Date(2000, 0, 1, 11, 1, 1), 'h', 1)).toEqual('11');
      expect(formatter.hour(new Date(2000, 0, 1, 12, 1, 1), 'h', 1)).toEqual('12');
      expect(formatter.hour(new Date(2000, 0, 1, 23, 1, 1), 'h', 1)).toEqual('11');
    });

    it("test: hh", function() {
      expect(formatter.hour(new Date(2000, 0, 1,  0, 1, 1), 'hh', 2)).toEqual('12');
      expect(formatter.hour(new Date(2000, 0, 1,  1, 1, 1), 'hh', 2)).toEqual('01');
      expect(formatter.hour(new Date(2000, 0, 1, 11, 1, 1), 'hh', 2)).toEqual('11');
      expect(formatter.hour(new Date(2000, 0, 1, 12, 1, 1), 'hh', 2)).toEqual('12');
      expect(formatter.hour(new Date(2000, 0, 1, 23, 1, 1), 'hh', 2)).toEqual('11');
    });

    it("test: H", function() {
      expect(formatter.hour(new Date(2000, 0, 1,  0, 1, 1), 'H', 1)).toEqual('0');
      expect(formatter.hour(new Date(2000, 0, 1,  1, 1, 1), 'H', 1)).toEqual('1');
      expect(formatter.hour(new Date(2000, 0, 1, 11, 1, 1), 'H', 1)).toEqual('11');
      expect(formatter.hour(new Date(2000, 0, 1, 12, 1, 1), 'H', 1)).toEqual('12');
      expect(formatter.hour(new Date(2000, 0, 1, 23, 1, 1), 'H', 1)).toEqual('23');
    });

    it("test: HH", function() {
      expect(formatter.hour(new Date(2000, 0, 1,  0, 1, 1), 'HH', 2)).toEqual('00');
      expect(formatter.hour(new Date(2000, 0, 1,  1, 1, 1), 'HH', 2)).toEqual('01');
      expect(formatter.hour(new Date(2000, 0, 1, 11, 1, 1), 'HH', 2)).toEqual('11');
      expect(formatter.hour(new Date(2000, 0, 1, 12, 1, 1), 'HH', 2)).toEqual('12');
      expect(formatter.hour(new Date(2000, 0, 1, 23, 1, 1), 'HH', 2)).toEqual('23');
    });

    it("test: K", function() {
      expect(formatter.hour(new Date(2000, 0, 1,  0, 1, 1), 'K', 1)).toEqual('0');
      expect(formatter.hour(new Date(2000, 0, 1,  1, 1, 1), 'K', 1)).toEqual('1');
      expect(formatter.hour(new Date(2000, 0, 1, 11, 1, 1), 'K', 1)).toEqual('11');
      expect(formatter.hour(new Date(2000, 0, 1, 12, 1, 1), 'K', 1)).toEqual('0');
      expect(formatter.hour(new Date(2000, 0, 1, 23, 1, 1), 'K', 1)).toEqual('11');
    });

    it("test: KK", function() {
      expect(formatter.hour(new Date(2000, 0, 1,  0, 1, 1), 'KK', 2)).toEqual('00');
      expect(formatter.hour(new Date(2000, 0, 1,  1, 1, 1), 'KK', 2)).toEqual('01');
      expect(formatter.hour(new Date(2000, 0, 1, 11, 1, 1), 'KK', 2)).toEqual('11');
      expect(formatter.hour(new Date(2000, 0, 1, 12, 1, 1), 'KK', 2)).toEqual('00');
      expect(formatter.hour(new Date(2000, 0, 1, 23, 1, 1), 'KK', 2)).toEqual('11');
    });

    it("test: k", function() {
      expect(formatter.hour(new Date(2000, 0, 1,  0, 1, 1), 'k', 1)).toEqual('24');
      expect(formatter.hour(new Date(2000, 0, 1,  1, 1, 1), 'k', 1)).toEqual('1');
      expect(formatter.hour(new Date(2000, 0, 1, 11, 1, 1), 'k', 1)).toEqual('11');
      expect(formatter.hour(new Date(2000, 0, 1, 12, 1, 1), 'k', 1)).toEqual('12');
      expect(formatter.hour(new Date(2000, 0, 1, 23, 1, 1), 'k', 1)).toEqual('23');
    });

    it("test: kk", function() {
      expect(formatter.hour(new Date(2000, 0, 1,  0, 1, 1), 'kk', 2)).toEqual('24');
      expect(formatter.hour(new Date(2000, 0, 1,  1, 1, 1), 'kk', 2)).toEqual('01');
      expect(formatter.hour(new Date(2000, 0, 1, 11, 1, 1), 'kk', 2)).toEqual('11');
      expect(formatter.hour(new Date(2000, 0, 1, 12, 1, 1), 'kk', 2)).toEqual('12');
      expect(formatter.hour(new Date(2000, 0, 1, 23, 1, 1), 'kk', 2)).toEqual('23');
    });
  });

  describe("#minute", function() {
    it("test: m", function() {
      expect(formatter.minute(new Date(2000, 0, 1, 1,  1, 1), 'm', 1)).toEqual('1');
      expect(formatter.minute(new Date(2000, 0, 1, 1, 11, 1), 'm', 1)).toEqual('11');
    });

    it("test: mm", function() {
      expect(formatter.minute(new Date(2000, 0, 1, 1,  1, 1), 'mm', 2)).toEqual('01');
      expect(formatter.minute(new Date(2000, 0, 1, 1, 11, 1), 'mm', 2)).toEqual('11');
    });
  });

	// NOTE: months in JavaScript are zero-based, meaning Jan = 0, Dec = 11
  describe("#month", function() {
    it("test: pattern M", function() {
      expect(formatter.month(new Date(2010, 0, 1), 'M', 1)).toEqual('1');
      expect(formatter.month(new Date(2010, 9, 1), 'M', 1)).toEqual('10');
    });

    it("test: pattern MM", function() {
      expect(formatter.month(new Date(2010, 0, 1), 'MM', 2)).toEqual('01');
      expect(formatter.month(new Date(2010, 9, 1), 'MM', 2)).toEqual('10');
    });

    it("test: pattern MMM", function() {
      expect(formatter.month(new Date(2010, 0, 1), 'MMM', 3)).toEqual('Jan');
      expect(formatter.month(new Date(2010, 9, 1), 'MMM', 3)).toEqual('Oct');
    });

    it("test: pattern MMMM", function() {
      expect(formatter.month(new Date(2010, 0, 1), 'MMMM', 4)).toEqual('January');
      expect(formatter.month(new Date(2010, 9, 1), 'MMMM', 4)).toEqual('October');
    });

    it("test: pattern L", function() {
      expect(formatter.month(new Date(2010,  0, 1), 'L', 1)).toEqual('1');
      expect(formatter.month(new Date(2010, 9, 1), 'L', 1)).toEqual('10');
    });

    it("test: pattern LL", function() {
      expect(formatter.month(new Date(2010,  0, 1), 'LL', 2)).toEqual('01');
      expect(formatter.month(new Date(2010, 9, 1), 'LL', 2)).toEqual('10');
    });
	});

  describe("#period", function() {
    it("test: a", function() {
      expect(formatter.period(new Date(2000, 0, 1, 1, 1, 1), 'a', 1)).toEqual('AM');
      expect(formatter.period(new Date(2000, 0, 1, 15, 1, 1), 'a', 1)).toEqual('PM');
    });
  });

  describe("#quarter", function() {
    it("test: pattern Q", function() {
      expect(formatter.quarter(new Date(2010, 0,  1),  'Q', 1)).toEqual('1');
      expect(formatter.quarter(new Date(2010, 2, 31),  'Q', 1)).toEqual('1');
      expect(formatter.quarter(new Date(2010, 3,  1),  'Q', 1)).toEqual('2');
      expect(formatter.quarter(new Date(2010, 5, 30),  'Q', 1)).toEqual('2');
      expect(formatter.quarter(new Date(2010, 6,  1),  'Q', 1)).toEqual('3');
      expect(formatter.quarter(new Date(2010, 8, 30),  'Q', 1)).toEqual('3');
      expect(formatter.quarter(new Date(2010, 9,  1),  'Q', 1)).toEqual('4');
      expect(formatter.quarter(new Date(2010, 11, 31), 'Q', 1)).toEqual('4');
    });

    it("test: pattern QQ", function() {
      expect(formatter.quarter(new Date(2010, 0,  1),  'QQ', 2)).toEqual('01');
      expect(formatter.quarter(new Date(2010, 2, 31),  'QQ', 2)).toEqual('01');
      expect(formatter.quarter(new Date(2010, 3,  1),  'QQ', 2)).toEqual('02');
      expect(formatter.quarter(new Date(2010, 5, 30),  'QQ', 2)).toEqual('02');
      expect(formatter.quarter(new Date(2010, 6,  1),  'QQ', 2)).toEqual('03');
      expect(formatter.quarter(new Date(2010, 8, 30),  'QQ', 2)).toEqual('03');
      expect(formatter.quarter(new Date(2010, 9,  1),  'QQ', 2)).toEqual('04');
      expect(formatter.quarter(new Date(2010, 11, 31), 'QQ', 2)).toEqual('04');
    });

    it("test: pattern QQQ", function() {
      expect(formatter.quarter(new Date(2010, 0,  1),  'QQQ', 3)).toEqual('Q1');
      expect(formatter.quarter(new Date(2010, 2, 31),  'QQQ', 3)).toEqual('Q1');
      expect(formatter.quarter(new Date(2010, 3,  1),  'QQQ', 3)).toEqual('Q2');
      expect(formatter.quarter(new Date(2010, 5, 30),  'QQQ', 3)).toEqual('Q2');
      expect(formatter.quarter(new Date(2010, 6,  1),  'QQQ', 3)).toEqual('Q3');
      expect(formatter.quarter(new Date(2010, 8, 30),  'QQQ', 3)).toEqual('Q3');
      expect(formatter.quarter(new Date(2010, 9,  1),  'QQQ', 3)).toEqual('Q4');
      expect(formatter.quarter(new Date(2010, 11, 31), 'QQQ', 3)).toEqual('Q4');
    });

    it("test: pattern QQQQ", function() {
      expect(formatter.quarter(new Date(2010, 0,  1),  'QQQQ', 4)).toEqual('1st quarter');
      expect(formatter.quarter(new Date(2010, 2, 31),  'QQQQ', 4)).toEqual('1st quarter');
      expect(formatter.quarter(new Date(2010, 3,  1),  'QQQQ', 4)).toEqual('2nd quarter');
      expect(formatter.quarter(new Date(2010, 5, 30),  'QQQQ', 4)).toEqual('2nd quarter');
      expect(formatter.quarter(new Date(2010, 6,  1),  'QQQQ', 4)).toEqual('3rd quarter');
      expect(formatter.quarter(new Date(2010, 8, 30),  'QQQQ', 4)).toEqual('3rd quarter');
      expect(formatter.quarter(new Date(2010, 9,  1),  'QQQQ', 4)).toEqual('4th quarter');
      expect(formatter.quarter(new Date(2010, 11, 31), 'QQQQ', 4)).toEqual('4th quarter');
    });

    it("test: pattern q", function() {
      expect(formatter.quarter(new Date(2010, 0,  1),  'q', 1)).toEqual('1');
      expect(formatter.quarter(new Date(2010, 2, 31),  'q', 1)).toEqual('1');
      expect(formatter.quarter(new Date(2010, 3,  1),  'q', 1)).toEqual('2');
      expect(formatter.quarter(new Date(2010, 5, 30),  'q', 1)).toEqual('2');
      expect(formatter.quarter(new Date(2010, 6,  1),  'q', 1)).toEqual('3');
      expect(formatter.quarter(new Date(2010, 8, 30),  'q', 1)).toEqual('3');
      expect(formatter.quarter(new Date(2010, 9,  1),  'q', 1)).toEqual('4');
      expect(formatter.quarter(new Date(2010, 11, 31), 'q', 1)).toEqual('4');
    });

    it("test: pattern qq", function() {
      expect(formatter.quarter(new Date(2010, 0,  1),  'qq', 2)).toEqual('01');
      expect(formatter.quarter(new Date(2010, 2, 31),  'qq', 2)).toEqual('01');
      expect(formatter.quarter(new Date(2010, 3,  1),  'qq', 2)).toEqual('02');
      expect(formatter.quarter(new Date(2010, 5, 30),  'qq', 2)).toEqual('02');
      expect(formatter.quarter(new Date(2010, 6,  1),  'qq', 2)).toEqual('03');
      expect(formatter.quarter(new Date(2010, 8, 30),  'qq', 2)).toEqual('03');
      expect(formatter.quarter(new Date(2010, 9,  1),  'qq', 2)).toEqual('04');
      expect(formatter.quarter(new Date(2010, 11, 31), 'qq', 2)).toEqual('04');
    });
  });

  describe("#second", function() {
    it("test: s", function() {
      expect(formatter.second(new Date(2000, 0, 1, 1, 1,  1), 's', 1)).toEqual('1');
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 11), 's', 1)).toEqual('11');
    });

    it("test: ss", function() {
      expect(formatter.second(new Date(2000, 0, 1, 1, 1,  1), 'ss', 2)).toEqual('01');
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 11), 'ss', 2)).toEqual('11');
    });

    it("test: S", function() {
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 0),  'S', 1)).toEqual('0');
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 1),  'S', 1)).toEqual('1');
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 18), 'S', 1)).toEqual('18');
    });

    it("test: SS", function() {
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 0),  'SS', 2)).toEqual('00');
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 1),  'SS', 2)).toEqual('01');
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 8),  'SS', 2)).toEqual('08');
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 21), 'SS', 2)).toEqual('21');
    });

    it("test: SSS", function() {
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 0),  'SSS', 3)).toEqual('000');
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 1),  'SSS', 3)).toEqual('001');
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 8),  'SSS', 3)).toEqual('008');
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 21), 'SSS', 3)).toEqual('021');
    });

    it("test: SSSS", function() {
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 0),  'SSSS', 4)).toEqual('0000');
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 1),  'SSSS', 4)).toEqual('0001');
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 8),  'SSSS', 4)).toEqual('0008');
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 21), 'SSSS', 4)).toEqual('0021');
    });

    it("test: SSSSS", function() {
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 1),  'SSSSS', 5)).toEqual('00001')
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 8),  'SSSSS', 5)).toEqual('00008')
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 21), 'SSSSS', 5)).toEqual('00021')
    });

    it("test: SSSSSS", function() {
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 1),  'SSSSSS', 6)).toEqual('000001')
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 8),  'SSSSSS', 6)).toEqual('000008')
      expect(formatter.second(new Date(2000, 0, 1, 1, 1, 21), 'SSSSSS', 6)).toEqual('000021')
    });
  });

  describe("#timezone", function() {
		beforeEach(function() {
			date = new Date(2000, 0, 1, 1, 1, 1);
		});

    it("test: z, zz, zzz", function() {
      expect(formatter.timezone(date, 'z', 1)).toMatch(/^(-|\+)\d{2}:\d{2}$/);
      expect(formatter.timezone(date, 'zz', 2)).toMatch(/^(-|\+)\d{2}:\d{2}$/);
      expect(formatter.timezone(date, 'zzz', 3)).toMatch(/^(-|\+)\d{2}:\d{2}$/);
      expect(formatter.timezone(date, 'zzzz', 4)).toMatch(/^UTC (-|\+)\d{2}:\d{2}$/);
    });
  });

	// javascript handles dates differently than Ruby does, hence why this spec expects different results than it's Ruby counterpart
	// eg. new Date(5, 0).getFullYear() == 1905
  describe("#year", function() {
    it("test: pattern y", function() {
      expect(formatter.year(new Date(    5, 0, 1), 'y', 1)).toEqual('1905');
      expect(formatter.year(new Date(   45, 0, 1), 'y', 1)).toEqual('1945');
      expect(formatter.year(new Date(  345, 0, 1), 'y', 1)).toEqual('345');
      expect(formatter.year(new Date( 2345, 0, 1), 'y', 1)).toEqual('2345');
      expect(formatter.year(new Date(12345, 0, 1), 'y', 1)).toEqual('12345');
    });

    it("test: pattern yy", function() {
      expect(formatter.year(new Date(    5, 0, 1), 'yy', 2)).toEqual('05');
      expect(formatter.year(new Date(   45, 0, 1), 'yy', 2)).toEqual('45');
      expect(formatter.year(new Date(  345, 0, 1), 'yy', 2)).toEqual('45');
      expect(formatter.year(new Date( 2345, 0, 1), 'yy', 2)).toEqual('45');
      expect(formatter.year(new Date(12345, 0, 1), 'yy', 2)).toEqual('45');
    });

    it("test: pattern yyy", function() {
      expect(formatter.year(new Date(    5, 0, 1), 'yyy', 3)).toEqual('905');
      expect(formatter.year(new Date(   45, 0, 1), 'yyy', 3)).toEqual('945');
      expect(formatter.year(new Date(  345, 0, 1), 'yyy', 3)).toEqual('345');
      expect(formatter.year(new Date( 2345, 0, 1), 'yyy', 3)).toEqual('345');
      expect(formatter.year(new Date(12345, 0, 1), 'yyy', 3)).toEqual('345');
    });

    it("test: pattern yyyy", function() {
      expect(formatter.year(new Date(    5, 0, 1), 'yyyy', 4)).toEqual('1905');
      expect(formatter.year(new Date(   45, 0, 1), 'yyyy', 4)).toEqual('1945');
      expect(formatter.year(new Date(  345, 0, 1), 'yyyy', 4)).toEqual('0345');
      expect(formatter.year(new Date( 2345, 0, 1), 'yyyy', 4)).toEqual('2345');
      expect(formatter.year(new Date(12345, 0, 1), 'yyyy', 4)).toEqual('2345');
    });

    it("test: pattern yyyyy", function() {
      expect(formatter.year(new Date(    5, 0, 1), 'yyyyy', 5)).toEqual('01905');
      expect(formatter.year(new Date(   45, 0, 1), 'yyyyy', 5)).toEqual('01945');
      expect(formatter.year(new Date(  345, 0, 1), 'yyyyy', 5)).toEqual('00345');
      expect(formatter.year(new Date( 2345, 0, 1), 'yyyyy', 5)).toEqual('02345');
      expect(formatter.year(new Date(12345, 0, 1), 'yyyyy', 5)).toEqual('12345');
    });
  });
});