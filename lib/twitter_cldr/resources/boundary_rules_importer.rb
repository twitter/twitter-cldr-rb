# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'fileutils'
require 'yaml'
require 'base64'

module TwitterCldr
  module Resources

    class BoundaryRulesImporter < Importer

      # @TODO: moar boundary types
      BOUNDARY_TYPES = ['word'].freeze

      StateTable  = TwitterCldr::Segmentation::StateTable
      StatusTable = TwitterCldr::Segmentation::StatusTable
      Trie        = TwitterCldr::Segmentation::Trie

      requirement :icu, Versions.icu_version
      output_path File.join('shared', 'segments')
      ruby_engine :jruby

      def execute
        FileUtils.mkdir_p(output_path)

        BOUNDARY_TYPES.each do |kind|
          output_file = File.join(output_path, "#{kind}.yml")
          File.write(output_file, YAML.dump(data_for(kind)))
        end
      end

      private

      def data_for(kind)
        data = rbbi_data_for(kind)

        {
          metadata: metadata_from(data.fHeader),
          forward_table: StateTable.new(data.fFTable.fTable.to_a).dump16.strip,
          backward_table: StateTable.new(data.fRTable.fTable.to_a).dump16.strip,
          status_table: StatusTable.new(data.fStatusTable.to_a).dump.strip,
          trie: encode_trie(data.fTrie)
        }
      end

      def metadata_from(header)
        { category_count: header.fCatCount }
      end

      def encode_trie(trie)
        arr = [].tap do |results|
          iter = trie.iterator

          while iter.hasNext
            range = iter.next
            results << range_to_a(range)

            # this should be the last entry, but for some reason ICU returns
            # one more out-of-order range past the Unicode max
            break if range.endCodePoint == 0x10FFFF
          end
        end

        # @TODO: Distinguish between the 16- and 32-bit flavors
        Trie.new(arr).dump16.strip
      end

      def range_to_a(range)
        [range.startCodePoint, range.endCodePoint, range.value]
      end

      def rbbi_data_for(kind)
        brkf_name = bundle.getStringWithFallback("boundaries/#{kind}")
        buffer = icu_binary.getData("#{brkiter_name}/#{brkf_name}")
        rbbi_data_wrapper.get(buffer)
      end

      def bundle
        @bundle ||= resource_bundle.getBundleInstance(brkiter_base_name, nil, locale_root)
      end

      def brkiter_name
        @brkiter_name ||= icu_data.const_get(:ICU_BRKITR_NAME)
      end

      def brkiter_base_name
        @brkiter_base_name ||= icu_data.const_get(:ICU_BRKITR_BASE_NAME)
      end

      def locale_root
        @locale_root ||= resource_bundle.const_get(:OpenType).const_get(:LOCALE_ROOT)
      end

      def rbbi_data_wrapper
        @rbbi_data_wrapper ||= requirements[:icu].get_class('com.ibm.icu.impl.RBBIDataWrapper')
      end

      def icu_binary
        @icu_binary ||= requirements[:icu].get_class('com.ibm.icu.impl.ICUBinary')
      end

      def icu_data
        @icu_data ||= requirements[:icu].get_class('com.ibm.icu.impl.ICUData')
      end

      def resource_bundle
        @bundle_class ||= requirements[:icu].get_class('com.ibm.icu.impl.ICUResourceBundle')
      end

      def output_path
        params[:output_path]
      end

    end
  end
end
