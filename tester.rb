require 'twitter_cldr'
require 'pry-nav'

tz = TwitterCldr::Timezones::LocationTimezone.new('America/Havana', :es)
puts tz.to_s
