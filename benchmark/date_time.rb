# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'rbench'
require 'twitter_cldr'

RBench.run(1000) do
  locales = [:en, :ja, :ar, :ru, :da]

  column :times

  locales.each do |locale|
    column locale, :title => locale.to_s
  end

  group "Dates and times" do

    (TwitterCldr::Localized::LocalizedDateTime.types - [:additional]).each do |type|
      report "#{type} times" do
        locales.each do |locale|
          __send__(locale) { Time.now.localize(locale).send(:"to_#{type}_s") }
        end
      end

      report "#{type} datetimes" do
        locales.each do |locale|
          __send__(locale) { DateTime.now.localize(locale).send(:"to_#{type}_s") }
        end
      end
    end

    report "Additional datetimes" do
      locales.each do |locale|
        __send__(locale) { DateTime.now.localize(locale).to_additional_s("GyMMMEd") }
      end
    end

  end
end
