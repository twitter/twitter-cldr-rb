require 'twitter_cldr'
require 'pry-nav'

tz = TwitterCldr::Timezones::Timezone.new('America/St_Johns', :he)
puts tz.display_name_for(Time.now, :short_gmt)
