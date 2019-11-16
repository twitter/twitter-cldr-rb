require 'twitter_cldr'
require 'pry-nav'

tz = TwitterCldr::Timezones::Timezone.new('Etc/GMT+1', :en)
puts tz.display_name_for(Time.now, :long_generic)
