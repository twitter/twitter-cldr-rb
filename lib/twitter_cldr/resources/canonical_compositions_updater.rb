# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources

    class CanonicalCompositionsUpdater

      CODE_POINT_MAX = 0x10FFFF

      # Arguments:
      #
      #   output_path - output directory for generated YAML file
      #
      def initialize(output_path)
        @output_path = output_path
      end

      def update
        File.open(File.join(@output_path, 'canonical_compositions.yml'), 'w') do |output|
          YAML.dump(generate_compositions, output)
        end
      end

      private

      def generate_compositions
        (1..CODE_POINT_MAX).inject({}) do |memo, code_point|
          code_point_data = TwitterCldr::Shared::CodePoint.find(code_point)

          if code_point_data && !code_point_data.compatibility_decomposition? && code_point_data.decomposition && !code_point_data.decomposition.empty?
            memo[code_point_data.decomposition] = code_point
          end

          log_progress(code_point, memo.size)

          memo
        end
      end

      def log_progress(code_point, compositions_count)
        $stdout.write("\r#{(100.0 * code_point / CODE_POINT_MAX).round}% complete, found #{compositions_count} canonical compositions")
        $stdout.write("\n") if code_point == CODE_POINT_MAX
      end

    end

  end
end