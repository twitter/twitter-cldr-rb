# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Caser do
  describe '.upcase' do
    it 'uppercases a Latin sample' do
      str = "I like cats. They're the best."
      expect(Caser.upcase(str)).to eq(
        "I LIKE CATS. THEY'RE THE BEST."
      )
    end

    it 'uppercases a Cyrillic sample' do
      str = 'Влади́мир Влади́мирович Пу́тин'
      expect(Caser.upcase(str)).to eq(
        'ВЛАДИ́МИР ВЛАДИ́МИРОВИЧ ПУ́ТИН'
      )
    end

    it 'uppercases a Greek sample' do
      str = 'Αλφαβητικός Κατάλογος'
      expect(Caser.upcase(str)).to eq(
        'ΑΛΦΑΒΗΤΙΚΌΣ ΚΑΤΆΛΟΓΟΣ'
      )
    end
  end

  describe '.downcase' do
    it 'lowercases a Latin sample' do
      str = "I LIKE CATS. THEY'RE THE BEST."
      expect(Caser.downcase(str)).to eq(
        "i like cats. they're the best."
      )
    end

    it 'lowercases a Cyrillic sample' do
      str = 'ВЛАДИ́МИР ВЛАДИ́МИРОВИЧ ПУ́ТИН'
      expect(Caser.downcase(str)).to eq(
        'влади́мир влади́мирович пу́тин'
      )
    end

    it 'lowercases a Greek sample' do
      str = 'ΑΛΦΑΒΗΤΙΚΌΣ ΚΑΤΆΛΟΓΟΣ'
      expect(Caser.downcase(str)).to eq(
        'αλφαβητικόσ κατάλογοσ'
      )
    end
  end

  describe '.titlecase' do
    it 'titlecases a Latin sample' do
      str = 'I LIKE CATS'
      expect(Caser.titlecase(str)).to eq(
        'I Like Cats'
      )
    end

    it 'lowercases a Cyrillic sample' do
      str = 'ВЛАДИ́МИР ВЛАДИ́МИРОВИЧ ПУ́ТИН'
      expect(Caser.titlecase(str)).to eq(
        'Влади́мир Влади́мирович Пу́тин'
      )
    end

    it 'lowercases a Greek sample' do
      str = 'ΑΛΦΑΒΗΤΙΚΌΣ ΚΑΤΆΛΟΓΟΣ'
      expect(Caser.titlecase(str)).to eq(
        'Αλφαβητικόσ Κατάλογοσ'
      )
    end
  end
end
