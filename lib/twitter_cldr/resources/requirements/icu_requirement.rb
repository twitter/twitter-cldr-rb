# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'open-uri'

module TwitterCldr
  module Resources
    module Requirements

      # This requirement makes use of the JarClassLoader package (https://github.com/kamranzafar/JCL)
      # to load ICU in an isolated environment to keep different versions of the
      # library separate. If ICU versions are not kept separate, the one that's
      # first on the classpath wins, which can be surprising if you're not
      # expecting it. Oh, and it can break all the tests.
      class IcuRequirement
        ICU_URL = "http://download.icu-project.org/files/icu4j/%{version}/icu4j-%{underscored_version}.jar"

        # first entry is JCL itself, other two are JCL dependencies
        JCL_JARS = [
          'https://repo.maven.apache.org/maven2/org/xeustechnologies/jcl-core/2.7/jcl-core-2.7.jar',
          'https://repo.maven.apache.org/maven2/org/objenesis/objenesis/2.1/objenesis-2.1.jar',
          'https://repo.maven.apache.org/maven2/cglib/cglib-nodep/2.2/cglib-nodep-2.2.jar'
        ]

        attr_reader :version

        def initialize(version)
          @version = version
        end

        def prepare
          download_icu
          download_jcl

          JCL_JARS.each do |jcl_jar_url|
            require jcl_source_path_for(jcl_jar_url)
          end

          java_import 'org.xeustechnologies.jcl.JarClassLoader'

          class_loader.add(icu_source_path)
        end

        def icu_source_path
          @source_path ||= File.join(
            TwitterCldr::VENDOR_DIR, "icu_v#{version}.jar"
          )
        end

        def jcl_source_path_for(url)
          File.join(TwitterCldr::VENDOR_DIR, File.basename(url))
        end

        def get_class(name)
          class_loader.load_class(name).ruby_class
        end

        private

        def class_loader
          @class_loader ||= JarClassLoader.new
        end

        def download_icu
          unless File.file?(icu_source_path)
            STDOUT.write("Downloading icu v#{version}... ")
            download(icu_url, icu_source_path)
            puts 'done'
          end

          puts "Using icu #{version} from #{icu_source_path}"
        end

        def download_jcl
          JCL_JARS.each do |jcl_jar_url|
            source_path = jcl_source_path_for(jcl_jar_url)
            jar_name = File.basename(source_path).chomp(File.extname(source_path))

            unless File.file?(source_path)
              STDOUT.write("Downloading #{jar_name}... ")
              download(jcl_jar_url, source_path)
              puts 'done'
            end

            puts "Using #{jar_name} from #{source_path}"
          end
        end

        def download(url, path)
          open(path, 'wb') do |file|
            file << open(url).read
          end
        end

        def icu_url
          ICU_URL % {
            version: version,
            underscored_version: underscored_version
          }
        end

        def underscored_version
          @underscored_version ||= version.gsub('.', '_')
        end
      end

    end
  end
end
