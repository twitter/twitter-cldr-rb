# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources

    class CompositionExclusionsImporter

      COMPOSITION_EXCLUSION_REGEXP = /^([0-9A-F]+)(?:\.\.([0-9A-F]+))?\s+; Full_Composition_Exclusion #.*$/
      TOTAL_CODE_POINTS_REGEXP     = /^# Total code points: (\d+)$/

      # Arguments:
      #
      #   input_file - path to DerivedNormalizationProps.txt file (available at http://www.unicode.org/Public/6.1.0/ucd/DerivedNormalizationProps.txt)
      #
      #   output_path - output directory for generated YAML file
      #
      def initialize(input_file, output_path)
        @input_file  = input_file
        @output_path = output_path
      end

      def import
        File.open(File.join(@output_path, 'composition_exclusions.yml'), 'w') do |output|
          YAML.dump(generate_composition_exclusions, output)
        end
      end

      private

      def generate_composition_exclusions
        data      = File.open(@input_file) { |file| file.read }
        start_pos = data.index("# Derived Property: Full_Composition_Exclusion")
        end_pos   = data.index(/^#\s=*$/, start_pos)
        data      = data[start_pos..end_pos].split("\n")

        expected_code_points_count = nil

        result = data.inject([]) do |memo, line|
          memo << ($1.hex..($2 || $1).hex)     if line =~ COMPOSITION_EXCLUSION_REGEXP
          expected_code_points_count = $1.to_i if line =~ TOTAL_CODE_POINTS_REGEXP
          memo
        end

        raise "Expected number of code points was not found." unless expected_code_points_count
        code_points_count = result.map(&:count).inject(:+)
        raise "Unexpected number of code points: expected - #{expected_code_points_count}, got - #{code_points_count}." unless code_points_count == expected_code_points_count

        result
      end

    end
  end
end