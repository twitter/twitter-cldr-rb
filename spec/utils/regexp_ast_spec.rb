# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Utils

describe RegexpAst do
  let(:ast) do
    RegexpAst::Root.new(
      [RegexpAst::Literal.new([], nil, 'foobar')], nil
    )
  end

  let(:ast_dump) do
    "BAhvOihUd2l0dGVyQ2xkcjo6VXRpbHM6OlJlZ2V4cEFzdDo6Um9vdAc6EUBl\n" +
    "eHByZXNzaW9uc1sGbzorVHdpdHRlckNsZHI6OlV0aWxzOjpSZWdleHBBc3Q6\n" +
    "OkxpdGVyYWwIOgpAdGV4dEkiC2Zvb2JhcgY6BkVUOwZbADoQQHF1YW50aWZp\n" +
    "ZXIwOwow\n"
  end

  describe "#dump" do
    it "should serialize the ast to a correct base64-encoded string" do
      RegexpAst.dump(ast).should == ast_dump
    end
  end

  describe "#load" do
    it "should load the dumped ast and construct a valid object" do
      obj = RegexpAst.load(ast_dump)
      obj.should be_a(RegexpAst::Root)
      expr = obj.expressions.first
      expr.should be_a(RegexpAst::Literal)
      expr.text.should == 'foobar'
    end
  end
end