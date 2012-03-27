## twitter-cldr-rb

    TwitterCldr uses Unicode's Common Locale Data Repository (CLDR) to format certain types of text into their
    localized equivalents.  Currently supported types of text include dates, times, currencies, decimals, and percentages.

## Features

    * CLDR is missing complete number data for: hu (Hungarian), id (Indonesian), msa (Malay), no (Norwegian),
      and zh-tw (Traditional Chinese)

## Synopsis

  TwitterCldr patches core Ruby objects like Fixnum and Date for an easy localization experience:

  1. Numbers (Fixnum, Bignum, and Float objects are supported)
     1337.localize(:es).to_s                                    # 1.337
     1337.localize(:es).to_currency.to_s                        # $1.337,00
     1337.localize(:es).to_currency.to_s(:currency => "EUR")    # €1.337,00
     1337.localize(:es).to_currency.to_s(:currency => "Peru")   # S/.1.337,00
     1337.localize(:es).to_percent.to_s                         # 1.337%
     1337.localize(:es).to_percent.to_s(:precision => 2)        # 1.337,00%

     NOTE: The :precision option can be used with all these number formatters.

  2. Dates and Times (Date, Time, and DateTime objects are supported)
     DateTime.now.localize(:es).to_full_s                       # 21:44:57 UTC -0800 lunes 12 de diciembre de 2011
     DateTime.now.localize(:es).to_long_s                       # 21:45:42 -08:00 12 de diciembre de 2011
     DateTime.now.localize(:es).to_medium_s                     # 21:46:09 12/12/2011
     DateTime.now.localize(:es).to_short_s                      # 21:47 12/12/11

     Date.today.localize(:es).to_full_s                         # lunes 12 de diciembre de 2011
     Date.today.localize(:es).to_long_s                         # 12 de diciembre de 2011
     Date.today.localize(:es).to_medium_s                       # 12/12/2011
     Date.today.localize(:es).to_short_s                        # 12/12/11

     Time.now.localize(:es).to_full_s                           # 21:44:57 UTC -0800
     Time.now.localize(:es).to_long_s                           # 21:45:42 -08:00
     Time.now.localize(:es).to_medium_s                         # 21:46:09
     Time.now.localize(:es).to_short_s                          # 21:47

  3. Plural Rules
     1.localize(:ru).plural_rule                                # :one
     2.localize(:ru).plural_rule                                # :few
     5.localize(:ru).plural_rule                                # :many

  4. World Languages
     :es.localize(:es).as_language_code                         # español

## Requirements

No external requirements.

## Installation

`gem install twitter_cldr`

## Authors

* Cameron C. Dutro: http://github.com/camertron
* Sven Fuchs: http://github.com/svenfuchs

## License

Copyright 2012 Twitter, Inc.

Licensed under the Apache License, Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
