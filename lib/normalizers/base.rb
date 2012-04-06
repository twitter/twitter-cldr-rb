# encoding: UTF-8

module TwitterCldr
  module Normalizers
    class Base
      def unicode_data
        data_path = File.join("#{File.dirname(__FILE__)}/data/")
        index = {}
        IO.readlines(File.join(data_path, 'UnicodeData.txt')).map do |line|
          property = line.split(';')
          code_point = property.first
          index[code_point] = property
        end
        index
      end
    end
  end
end