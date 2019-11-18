require 'twitter_cldr'
require 'pry-nav'

tz = TwitterCldr::Timezones::Timezone.new('Africa/Casablanca', :'sr-Latn-ME')
puts tz.display_name_for(Time.now, :long_generic)
