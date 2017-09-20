require 'twitter_cldr'
require 'pry-nav'

tz = TwitterCldr::Timezones::LocationTimezone.new('Africa/Abidjan', :ro)
puts tz.to_s
