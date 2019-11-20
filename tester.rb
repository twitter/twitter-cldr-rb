require 'twitter_cldr'
require 'pry-nav'
require 'benchmark/ips'

tz = TwitterCldr::Timezones::Timezone.instance('America/Los_Angeles', :en)

dst_time = Time.new(2019, 11, 1)
std_time = Time.new(2019, 2, 1)

# puts tz.display_name_for(dst_time, :specific_long)
# puts tz.display_name_for(std_time, :specific_long)

Benchmark.ips do |x|
  x.report do
    tz.display_name_for(std_time, :specific_long)
  end
end
