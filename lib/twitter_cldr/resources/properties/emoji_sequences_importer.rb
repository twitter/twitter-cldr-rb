# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources
    module Properties

      class EmojiSequencesImporter < EmojiImporter
        DATA_FILE = 'emoji-sequences.txt'

        requirement :emoji, Versions.emoji_version, [DATA_FILE]
        output_path 'unicode_data/properties'
        ruby_engine :mri

        private

        def source_path
          requirements[:emoji].source_path_for(DATA_FILE)
        end
      end

    end
  end
end
