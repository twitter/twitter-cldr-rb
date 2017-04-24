# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared

    class UnsupportedNumberingSystemError < StandardError; end

    class NumberingSystem
      class << self
        def for_name(name)
          name_cache[name] ||= begin
            if system = resource[name.to_sym]
              system_klass = NUMBERING_SYSTEMS.find do |sys|
                sys.compatible_resource?(system)
              end

              system_klass.from_resource(name, system)
            else
              raise UnsupportedNumberingSystemError,
                "'#{name}' is not a supported numbering system"
            end
          end
        end

        private

        def name_cache
          @name_cache ||= {}
        end

        def rules_cache
          @rules_cache ||= {}
        end

        def resource
          @resource ||= begin
            rsrc = TwitterCldr.get_resource(:shared, :numbering_systems)
            rsrc[:numbering_systems]
          end
        end
      end

      attr_reader :name

      def initialize(name)
        @name = name
      end

      def numeric?
        true
      end

      def algorithmic?
        false
      end
    end

    class NumericNumberingSystem < NumberingSystem
      class << self
        def compatible_resource?(resource)
          resource[:type] == 'numeric'
        end

        def from_resource(name, resource)
          new(name, resource[:digits])
        end
      end

      attr_reader :digits

      def initialize(name, digits)
        super(name)
        @digits = split_digits(digits)
      end

      def transliterate(number)
        number.to_s.gsub(/\d/) do |digit|
          digits[digit.to_i]
        end
      end

      def numeric?
        true
      end

      private

      def split_digits(str)
        str.unpack('U*').map { |digit| [digit].pack('U*') }
      end
    end

    class AlgorithmicNumberingSystem < NumberingSystem
      class << self
        def compatible_resource?(resource)
          resource[:type] == 'algorithmic'
        end

        def from_resource(name, resource)
          new(name, resource[:rules])
        end
      end

      attr_reader :locale, :rule_group, :rule_set

      def initialize(name, rules)
        super(name)
        @locale, @rule_group, @rule_set = rules.split('/')
      end

      def transliterate(number)
        formatter.format(number, rule_group: rule_group, rule_set: rule_set)
      end

      def algorithmic?
        true
      end

      private

      def formatter
        @formatter ||= TwitterCldr::Formatters::Rbnf::RbnfFormatter.new(locale)
      end
    end

    NUMBERING_SYSTEMS = [
      NumericNumberingSystem, AlgorithmicNumberingSystem
    ]
  end
end
