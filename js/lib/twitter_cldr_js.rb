$:.push(File.dirname(__FILE__))

require 'mustache'
require 'uglifier'

require 'compiler'
require 'renderers/bundle'
require 'renderers/calendars/datetime_renderer'

module TwitterCldr
  module Js
    def self.compile(options = {})
      TwitterCldr::Js::Compiler.new(options).compile do |bundle, locale|
        cur_file = (options[:file_name] || "twitter_cldr_%{locale}.js").gsub("%{locale}", locale.to_s)

        if options[:minify]
          ext = File.extname(cur_file)
          min_file = "#{cur_file.chomp(File.extname(cur_file))}.min#{ext}"
          File.open(File.join(build_dir, min_file), "w+") do |f|
            f.write(Uglifier.compile(bundle))
          end
        else
          File.open(File.join(build_dir, cur_file), "w+") do |f|
            f.write(bundle)
          end
        end
      end
    end

    def self.clean(output_dir = build_dir)
      FileUtils.rm_rf(Dir.glob(File.join(build_dir, "**")))
    end

    def self.build_dir
      unless defined?(@@build_dir)
        @@build_dir = File.join(File.dirname(File.dirname(__FILE__)), "build")
      end
      @@build_dir
    end

    def self.build_dir=(new_dir)
      @@build_dir = new_dir
    end

    def self.run_tests
      # clean dir, then build js
      FileUtils.rm_rf(Dir.glob(File.join(build_dir, "**")))
      compile(:file_name => "bundle.js", :locales => [:en])
    end
  end
end