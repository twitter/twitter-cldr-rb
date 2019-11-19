require 'twitter_cldr'
require 'pry-nav'

tz = TwitterCldr::Timezones::Timezone.new('America/Araguaina', :pt)
puts tz.display_name_for(Time.now, :short_generic)
