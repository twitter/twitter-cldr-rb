# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'fileutils'
require 'open-uri'
require 'json'

module TwitterCldr
  module Resources
    module Uli
      class SegmentExceptionsImporter < Resources::Importer

        REPO_URL = 'https://github.com/unicode-org/uli.git'.freeze
        GIT_SHA = '6acce954b913b121b6ab4bd4f8395e74dce2ae7c'.freeze

        requirement :git, REPO_URL, GIT_SHA
        output_path 'uli/segments'
        ruby_engine :mri

        def execute
          FileUtils.mkdir_p(output_path)
          each_file { |file| import_file(file) }
        end

        private

        def output_path
          params.fetch(:output_path)
        end

        def import_file(file)
          locale = File.basename(file).chomp('.json')
          output_file = File.join(output_path, "#{locale}.yml")
          exceptions = JSON.parse(File.read(file))

          File.write(
            output_file,

            YAML.dump(
              forwards_trie: serialize(
                forwards_trie_for(exceptions['data']['abbrs'])
              ),

              backwards_trie: serialize(
                backwards_trie_for(exceptions['data']['abbrs'])
              )
            )
          )
        end

        def serialize(trie)
          Marshal.dump(trie)
        end

        def forwards_trie_for(exceptions)
          TwitterCldr::Utils::Trie.new.tap do |trie|
            exceptions.each { |ex| trie.add(ex.codepoints, true) }
          end
        end

        def backwards_trie_for(exceptions)
          TwitterCldr::Utils::Trie.new.tap do |trie|
            exceptions.each { |ex| trie.add(ex.reverse.codepoints, true) }
          end
        end

        def each_file(&block)
          Dir.glob(File.join(input_path, 'abbrs', 'json', '*.json')).each(&block)
        end

        def input_path
          requirements[:git].source_path
        end

      end
    end
  end
end
