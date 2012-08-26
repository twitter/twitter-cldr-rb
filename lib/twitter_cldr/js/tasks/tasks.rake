# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

namespace :twitter_cldr do
  namespace :js do
    desc "Update gem's JavaScript assets"
    task :update do
      TwitterCldr::Js::Tasks.update
    end

    desc 'Compile JavaScript files (into OUTPUT_DIR or in ./twitter_cldr)'
    task :compile do
      TwitterCldr::Js::Tasks.compile
    end
  end
end