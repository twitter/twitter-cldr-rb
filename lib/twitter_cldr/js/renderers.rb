# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Js
    module Renderers
      autoload :Base,                   'twitter_cldr/js/renderers/base'
      autoload :Bundle,                 'twitter_cldr/js/renderers/bundle'
      autoload :ListRenderer,           'twitter_cldr/js/renderers/list_renderer'

      module Calendars
        autoload :DateTimeRenderer,     'twitter_cldr/js/renderers/calendars/datetime_renderer'
        autoload :TimespanRenderer,     'twitter_cldr/js/renderers/calendars/timespan_renderer'
      end

      module Numbers
        autoload :NumbersRenderer,      'twitter_cldr/js/renderers/numbers/numbers_renderer'
      end

      module PluralRules
        autoload :PluralRulesCompiler,  'twitter_cldr/js/renderers/plurals/rules/plural_rules_compiler'
        autoload :PluralRulesRenderer,  'twitter_cldr/js/renderers/plurals/rules/plural_rules_renderer'
      end

      module Shared
        autoload :CurrenciesRenderer,   'twitter_cldr/js/renderers/shared/currencies_renderer'
      end
    end
  end
end