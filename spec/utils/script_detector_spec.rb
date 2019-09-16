# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Utils::ScriptDetector do
  describe '#detect_scripts' do
    it 'should return an instance of ScriptDetectionResult' do
      result = described_class.detect_scripts('foo bar')
      expect(result).to be_a(TwitterCldr::Utils::ScriptDetectionResult)
    end

    samples = {
      'Latin'      => 'hello, world',
      'Cyrillic'   => 'Костюшко родился',
      'Katakana'   => 'ール・ヴィルヘルム・シェーレ',
      'Hiragana'   => 'に成功したことから',
      'Han'        => '三部曲的最後一部作品',
      'Greek'      => 'Πρωτεύον ονομάζεται κάθε',
      'Thai'       => 'จะทำให้ธาตุปริมาณมากพอที่จะมองเห็น',
      'Telugu'     => 'ప్రముఖ కవి, రచయిత, నాటక',
      'Tamil'      => 'பொருளாகும். இப்பூவின்',
      'Arabic'     => 'انقراض العصر الطباشيري-الثلاثي،',
      'Devanagari' => 'ऋग्वेदस्य ऐतरेयारण्यके अन्तर्गता',
      'Hangul'     => '뉴캐슬 유나이티드의 전통적인 유니폼 색상은',
      'Sinhala'    => 'මෙය ශ්‍රී ලංකාවේ මහනුවර',
      'Myanmar'    => 'ဒေါ်ဖွားယုံတို့က မွေးဖွားခဲ့သည်။',
      'Cherokee'   => 'ᎠᎵᏍᏕᎸᏙᏗ ᎠᏕᎸ ᎬᏗ • ᎪᎷᏩᏛᎲ ᎢᎬᏁᏗ',
      'Ethiopic'   => 'እንቋዕ ብደሓን መጻእኩም',
      'Georgian'   => 'მეტალიკაშ ორდოშიან ინნაჭარეფი'
    }

    samples.each_pair do |script_name, text|
      it "detects #{script_name} text" do
        expect(described_class.detect_scripts(text).best_guess).to eq(script_name)
      end
    end

    it 'provides scores for all the different characters in the text' do
      result = described_class.detect_scripts('hello 1234 world')
      expect(result.scores.keys.sort).to eq(%w(Common Latin))
      expect(result.scores['Latin']).to eq(0.625)
      expect(result.scores['Common']).to eq(0.375)
      expect(result.best_guess).to eq('Latin')
    end
  end
end

describe TwitterCldr::Utils::ScriptDetectionResult do
  describe '#best_guess' do
    it 'returns nil if no scripts were detected' do
      result = described_class.new({})
      expect(result.best_guess).to be_nil
    end
  end

  describe '#scripts' do
    it 'returns a list of all the scripts present in the string' do
      result = described_class.new('Cyrillic' => 1, 'Greek' => 2)
      expect(result.scripts.sort).to eq(%w(Cyrillic Greek))
    end
  end
end
