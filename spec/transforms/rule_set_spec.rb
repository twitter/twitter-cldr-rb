# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Transforms

describe RuleSet do
  test_data = YAML.load_file(
    File.join(File.dirname(__FILE__), 'test_data.yml')
  )

  test_data.each do |test|
    transformer = Transformer.get(test[:id])

    test[:samples].each_pair.with_index do |(source, target), idx|
      it "transforms sample ##{idx + 1} using #{test[:id]}" do
        puts test[:id]
        expect(transformer.transform(source)).to eq(target)
      end
    end
  end
end
