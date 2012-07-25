#!/usr/bin/env ruby

# This script builds and exports the JavaScript version of TwitterCLDR (http://github.com/twitter/twitter-cldr-rb).
#
# Run it like so:
#    OUTPUT_DIR=wherever/you/want ./build.rb
#

begin
  require 'rubygems' unless ENV['NO_RUBYGEMS']
rescue LoadError
  puts "You need to have rubygems installed to continue.  See: http://rubygems.org/pages/download/ for more info."
end

begin
  require 'twitter_cldr'
rescue LoadError
  puts "You need to have the twitter_cldr gem installed.  Run `gem install twitter_cldr`."
end

require 'fileutils'

TwitterCldr.require_js

if ENV["OUTPUT_DIR"]
  build_dir = ENV["OUTPUT_DIR"]
else
  build_dir = Dir.pwd
  puts "Building JavaScript files in the current directory."
  puts "(Use the OUTPUT_DIR environment variable to override)"
end

$stdout.write("Building... ")
$stdout.flush
TwitterCldr::Js.output_dir = build_dir
TwitterCldr::Js.make(:locales => TwitterCldr.supported_locales)
TwitterCldr::Js.install

puts "Done."