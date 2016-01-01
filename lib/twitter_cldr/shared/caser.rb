# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    class Caser
      REGEX = /./

      class << self
        def upcase(string)
          string.gsub(REGEX, uppercasing_hash)
        end

        def downcase(string)
          string.gsub(REGEX, lowercasing_hash)
        end

        def titlecase
        end

        private

        def uppercasing_hash
          @uppercasing_hash ||= Hash.new do |hash, key|
            memoize_value(:simple_uppercase_map, hash, key)
          end
        end

        def lowercasing_hash
          @lowercasing_hash ||= Hash.new do |hash, key|
            memoize_value(:simple_lowercase_map, hash, key)
          end
        end

        def titlecasing_hash
          @titlecasing_hash ||= Hash.new do |hash, key|
            memoize_value(:simple_titlecase_map, hash, key)
          end
        end

        def memoize_value(field, hash, key)
          cp = TwitterCldr::Shared::CodePoint.get(key.ord)
          mapped_result = cp.send(field)
          hash[key] = mapped_result ? mapped_result : key
        end
      end
    end
  end
end
