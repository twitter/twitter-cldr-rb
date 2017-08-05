require 'twitter_cldr'
require 'pry-nav'

puts TwitterCldr::Timezones::GmtTimezone.new('Asia/Tokyo').to_s
