# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Utils::RegexpAst do
  let(:ast) do
    described_class::Root.new(
      [described_class::Literal.new([], nil, 'foobar')], nil
    )
  end

  let(:ast_dump) do
    "BAhvOihUd2l0dGVyQ2xkcjo6VXRpbHM6OlJlZ2V4cEFzdDo6Um9vdAc6EUBl\n" +
    "eHByZXNzaW9uc1sGbzorVHdpdHRlckNsZHI6OlV0aWxzOjpSZWdleHBBc3Q6\n" +
    "OkxpdGVyYWwIOgpAdGV4dEkiC2Zvb2JhcgY6BkVUOwZbADoQQHF1YW50aWZp\n" +
    "ZXIwOwow\n"
  end

  def check_ast(obj)
    expect(obj).to be_a(described_class::Root)
    expr = obj.expressions.first
    expect(expr).to be_a(described_class::Literal)
    expect(expr.text).to eq('foobar')
  end

  describe "#dump" do
    it "should correctly serialize the ast" do
      obj = Marshal.load(Base64.decode64(described_class.dump(ast)))
      check_ast(obj)
    end
  end

  describe "#load" do
    it "should load the dumped ast and construct a valid object" do
      obj = described_class.load(ast_dump)
      check_ast(obj)
    end
  end
end
