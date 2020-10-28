require 'twitter_cldr'
require 'base64'
require 'brotli'
require 'xz'
require 'pry-nav'

trie = Marshal.load(File.read('resources/shared/segments/dictionaries/thaidict.dump'))
serializer = TwitterCldr::Utils::TrieSerializer.new(trie)
result = serializer.serialize
puts "Length: #{(result.length / 1024.0).round(1)}kb"
compressed = Brotli.deflate(result)
puts "Compressed (Brotli): #{(compressed.length / 1024.0).round(1)}kb"
puts "Compressed (Zlib): #{(Zlib::Deflate.deflate(result, Zlib::BEST_COMPRESSION).length / 1024.0).round(1)}kb"
puts "Compressed (xz): #{(XZ.compress(result).length / 1024.0).round(1)}kb"
compressed = XZ.compress(result)
encoded = Base64.strict_encode64(result)
puts "Encoded: #{(encoded.length / 1024.0).round(1)}kb"
compressed_encoded = Base64.strict_encode64(compressed)
puts "Compressed encoded: #{(compressed_encoded.length / 1024.0).round(1)}kb"
