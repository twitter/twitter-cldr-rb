require 'twitter_cldr'
require 'pry-nav'

pm = TwitterCldr::Resources::Requirements::PomManager.new('./vendor/maven/pom.xml')
pm.add_dependency('com.ibm.icu', 'icu4j', '64.2')
