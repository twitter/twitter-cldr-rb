namespace :twitter_cldr do
  task :update do
    build(
      :begin_msg  => "Updating build... ",
      :output_dir => File.expand_path(File.join(File.dirname(__FILE__), "../assets/javascripts/twitter_cldr")),
      :files      => { "twitter_cldr_%s.js" => false }
    )
  end

  task :compile do
    build(
      :begin_msg  => "Compiling build... ",
      :output_dir => get_output_dir,
      :files      => { "twitter_cldr_%s.min.js" => true, "twitter_cldr_%s.js" => false }
    )
  end

  def build(options = {})
    locales = get_locales
    $stdout.write(options[:begin_msg])

    compiler = TwitterCldr::Js::Compiler.new(:locales => locales)
    output_dir = options[:output_dir] || get_output_dir

    build_duration = time_operation do
      options[:files].each_pair do |file_pattern, minify|
        compiler.compile_each(:minify => minify) do |bundle, locale|
          out_file = File.join(output_dir, file_pattern % locale)
          FileUtils.mkdir_p(File.basename(output_dir))
          File.open(out_file, "w+") do |f|
            f.write(bundle)
          end
        end
      end
    end

    puts "done"
    puts build_summary(
      :locale_count => compiler.locales.size,
      :build_duration => build_duration,
      :dir => output_dir
    )
  end

  def build_summary(options = {})
    %Q(Built %{locale_count} %<{ "locale_count": { "one": "locale", "other": "locales" } }> %{timespan} into %{dir}).localize % {
      :locale_count => options[:locale_count],
      :timespan     => TwitterCldr::Localized::LocalizedTimespan.new(options[:build_duration], :locale => :en).to_s.downcase,
      :dir          => options[:dir]
    }
  end

  def time_operation
    start_time = Time.now.to_i
    yield
    Time.now.to_i - start_time
  end

  def get_output_dir
    ENV["OUTPUT_DIR"] || File.join(FileUtils.getwd, "twitter_cldr")
  end

  def get_locales
    if ENV["LOCALES"]
      locales = ENV["LOCALES"].split(",").map { |locale| TwitterCldr.convert_locale(locale.strip.downcase.to_sym) }
      bad_locales = locales.select { |locale| !TwitterCldr.supported_locale?(locale) }
      puts "Ignoring unsupported locales: #{bad_locales.join(", ")}"
      locales - bad_locales
    else
      TwitterCldr.supported_locales
    end
  end
end