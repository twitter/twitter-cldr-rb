# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Shared::Caser do
  describe '.upcase' do
    it 'uppercases a Latin sample' do
      str = "I like cats. They're the best."
      expect(described_class.upcase(str)).to eq(
        "I LIKE CATS. THEY'RE THE BEST."
      )
    end

    it 'uppercases a Cyrillic sample' do
      str = 'Влади́мир Влади́мирович Пу́тин'
      expect(described_class.upcase(str)).to eq(
        'ВЛАДИ́МИР ВЛАДИ́МИРОВИЧ ПУ́ТИН'
      )
    end

    it 'uppercases a Greek sample' do
      str = 'Αλφαβητικός Κατάλογος'
      expect(described_class.upcase(str)).to eq(
        'ΑΛΦΑΒΗΤΙΚΌΣ ΚΑΤΆΛΟΓΟΣ'
      )
    end
  end

  describe '.downcase' do
    it 'lowercases a Latin sample' do
      str = "I LIKE CATS. THEY'RE THE BEST."
      expect(described_class.downcase(str)).to eq(
        "i like cats. they're the best."
      )
    end

    it 'lowercases a Cyrillic sample' do
      str = 'ВЛАДИ́МИР ВЛАДИ́МИРОВИЧ ПУ́ТИН'
      expect(described_class.downcase(str)).to eq(
        'влади́мир влади́мирович пу́тин'
      )
    end

    it 'lowercases a Greek sample' do
      str = 'ΑΛΦΑΒΗΤΙΚΌΣ ΚΑΤΆΛΟΓΟΣ'
      expect(described_class.downcase(str)).to eq(
        'αλφαβητικόσ κατάλογοσ'
      )
    end
  end

  describe '.titlecase' do
    it 'titlecases a Latin sample' do
      str = 'I LIKE CATS'
      expect(described_class.titlecase(str)).to eq(
        'I Like Cats'
      )
    end

    it 'titlecases a Cyrillic sample' do
      str = 'ВЛАДИ́МИР ВЛАДИ́МИРОВИЧ ПУ́ТИН'
      expect(described_class.titlecase(str)).to eq(
        'Влади́мир Влади́мирович Пу́тин'
      )
    end

    it 'titlecases a Greek sample' do
      str = 'ΑΛΦΑΒΗΤΙΚΌΣ ΚΑΤΆΛΟΓΟΣ'
      expect(described_class.titlecase(str)).to eq(
        'Αλφαβητικόσ Κατάλογοσ'
      )
    end

    it 'titlecases a Japanese example' do
      str = '日本語'
      expect(described_class.titlecase(str)).to eq(
        '日本語'
      )
    end
  end
end
