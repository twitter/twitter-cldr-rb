# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Js
    module Renderers
      module PluralRules

        class PluralRulesRenderer < TwitterCldr::Js::Renderers::Base
          self.template_file = File.expand_path(File.join(File.dirname(__FILE__), "../../..", "mustache/plurals/rules.coffee"))

          def rules
            ruby_str = TwitterCldr.get_locale_resource(@locale, :plurals)[@locale]
            rule_str = ruby_str.scan(/lambda\s*\{\s*\|n\|(.*?)\}/).first.first.strip
            js_str = PluralRulesCompiler.rule_to_js(rule_str)
            hash = eval(ruby_str)
            %Q({"keys": #{hash[@locale][:i18n][:plural][:keys].to_json}, "rule": #{js_str}})
          end
        end

      end
    end
  end
end