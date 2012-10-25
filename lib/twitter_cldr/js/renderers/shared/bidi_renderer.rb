# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Js
    module Renderers
      module Shared

        class BidiRenderer < TwitterCldr::Js::Renderers::Base
          self.template_file = File.expand_path(File.join(File.dirname(__FILE__), "../..", "mustache/shared/bidi.coffee"))

          def initialize(options = {})
            super
            @prerender = options[:prerender]
          end

          def bidi_classes
            @@bidi_classes ||= if @prerender
              File.read(File.expand_path(File.join(File.dirname(__FILE__), "../..", "mustache/shared/prerender/bidi_classes.json")))
            else
              categories = rangify_code_points(code_points_by_category)

              categories.inject({}) do |ret, (bidi_class, ranges)|
                ret[bidi_class] ||= {}
                ranges.each do |range|
                  diff = range.first == range.last ? 0 : range.last - range.first
                  ret[bidi_class][diff] ||= []
                  ret[bidi_class][diff] << range.first
                end
                ret
              end.to_json
            end
          end

          protected

          def code_points_by_category
            (0..0x10FFFF).inject({}) do |ret, i|
              cp = TwitterCldr::Shared::CodePoint.find(i)
              if cp
                ret[cp.bidi_class] ||= []
                ret[cp.bidi_class] << i
              end
              ret
            end
          end

          def rangify_code_points(categories)
            categories.inject({}) do |ret, (bidi_class, cp_list)|
              ret[bidi_class] = find_ranges(cp_list)
              ret
            end
          end

          def find_ranges(list)
            ranges = []
            start_idx = 0
            list.each_with_index do |item, idx|
              if idx > 0
                if list[idx - 1] < (item - 1)
                  ranges << (list[start_idx]..list[idx - 1])
                  start_idx = idx
                end
              end
            end
            ranges << (list[start_idx]..list[list.size - 1]) unless list.empty?
            ranges
          end

        end

      end
    end
  end
end