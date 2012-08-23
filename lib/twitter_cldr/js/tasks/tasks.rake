# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

namespace :twitter_cldr do
  task :update do
    TwitterCldr::Js::Tasks.update
  end

  task :compile do
    TwitterCldr::Js::Tasks.compile
  end
end