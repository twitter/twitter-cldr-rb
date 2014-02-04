# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'rbench'
require 'twitter_cldr'

RBench.run(1000) do
  locales = [:en, :ja, :ar, :ru, :da]
  number = 32_654

  column :times

  locales.each do |locale|
    column locale, :title => locale.to_s
  end

  group "Numbers" do

    (TwitterCldr::Localized::LocalizedNumber.types - [:default]).each do |type|
      report "#{type} numbers" do
        locales.each do |locale|
          __send__(locale) { number.localize(locale).send(:"to_#{type}").to_s }
        end
      end
    end

  end
end
