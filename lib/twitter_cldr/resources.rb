# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources
    autoload :BidiTestImporter,               'twitter_cldr/resources/bidi_test_importer'
    autoload :CasefolderClassGenerator,       'twitter_cldr/resources/casefolder_class_generator'
    autoload :CollationTriesImporter,         'twitter_cldr/resources/collation_tries_importer'
    autoload :HyphenationImporter,            'twitter_cldr/resources/hyphenation_importer'
    autoload :Importer,                       'twitter_cldr/resources/importer'
    autoload :ImportResolver,                 'twitter_cldr/resources/import_resolver'
    autoload :LanguageCodesImporter,          'twitter_cldr/resources/language_codes_importer'
    autoload :Loader,                         'twitter_cldr/resources/loader'
    autoload :LocalesResourcesImporter,       'twitter_cldr/resources/locales_resources_importer'
    autoload :PhoneCodesImporter,             'twitter_cldr/resources/phone_codes_importer'
    autoload :PostalCodesImporter,            'twitter_cldr/resources/postal_codes_importer'
    autoload :Properties,                     'twitter_cldr/resources/properties'
    autoload :RbnfTestImporter,               'twitter_cldr/resources/rbnf_test_importer'
    autoload :ReadmeRenderer,                 'twitter_cldr/resources/readme_renderer'
    autoload :RegexpAstGenerator,             'twitter_cldr/resources/regexp_ast_generator'
    autoload :Requirements,                   'twitter_cldr/resources/requirements'
    autoload :SegmentTestsImporter,           'twitter_cldr/resources/segment_tests_importer'
    autoload :TailoringImporter,              'twitter_cldr/resources/tailoring_importer'
    autoload :TransformTestImporter,          'twitter_cldr/resources/transform_test_importer'
    autoload :UnicodeDataImporter,            'twitter_cldr/resources/unicode_data_importer'
    autoload :UnicodeFileParser,              'twitter_cldr/resources/unicode_file_parser'
    autoload :UnicodePropertyAliasesImporter, 'twitter_cldr/resources/unicode_property_aliases_importer'
    autoload :Uli,                            'twitter_cldr/resources/uli'

    class << self
      # these importer class methods aren't constants in order to avoid loading
      # all the classes when the library is required

      def standard_importer_classes
        @standard_importer_classes ||= [
          BidiTestImporter,
          CasefolderClassGenerator,
          CollationTriesImporter,
          HyphenationImporter,
          LanguageCodesImporter,
          LocalesResourcesImporter,
          PhoneCodesImporter,
          PostalCodesImporter,
          RbnfTestImporter,
          SegmentTestsImporter,
          TailoringImporter,
          TransformTestImporter,
          UnicodeDataImporter,
          UnicodePropertyAliasesImporter,
        ]
      end

      def uli_importer_classes
        @uli_importer_classes ||= [
          # Disabled for now since ULI TRAC has been down for quite a while.
          # Word is data will eventually be available in a git repo.
          # Uli::SegmentExceptionsImporter
        ]
      end

      def property_importer_classes
        @property_importer_classes ||= [
          Properties::AgePropertyImporter,
          Properties::ArabicShapingPropertyImporter,
          Properties::BidiBracketsPropertyImporter,
          Properties::BlocksPropertyImporter,
          Properties::DerivedCorePropertiesImporter,
          Properties::EastAsianWidthPropertyImporter,
          Properties::GraphemeBreakPropertyImporter,
          Properties::HangulSyllableTypePropertyImporter,
          Properties::IndicPositionalCategoryPropertyImporter,
          Properties::IndicSyllabicCategoryPropertyImporter,
          Properties::JamoPropertyImporter,
          Properties::LineBreakPropertyImporter,
          Properties::PropListImporter,
          Properties::ScriptExtensionsPropertyImporter,
          Properties::ScriptPropertyImporter,
          Properties::SentenceBreakPropertyImporter,
          Properties::UnicodeDataPropertiesImporter,
          Properties::WordBreakPropertyImporter
        ]
      end

      def importer_classes
        @importer_classes ||=
          standard_importer_classes +
          uli_importer_classes +
          property_importer_classes
      end

      def importer_classes_for_ruby_engine
        engine = case RUBY_ENGINE
          when 'ruby' then :mri
          when 'jruby' then :jruby
          else
            raise "Unsupported RUBY_ENGINE '#{RUBY_ENGINE}'"
        end

        importer_classes.select do |klass|
          klass.default_params[:ruby_engine] == engine
        end
      end

      def locale_based_importer_classes_for_ruby_engine
        importer_classes_for_ruby_engine.select do |klass|
          !!klass.default_params[:locales]
        end
      end
    end
  end
end
