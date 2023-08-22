# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe "README" do
  renderer = TwitterCldr::Resources::ReadmeRenderer.new(
    File.read(File.join(File.dirname(__FILE__), "../README.md.erb"))
  )

  renderer.render
  renderer.assertion_failures.each do |failure|
    it "encountered assertion failure on line #{failure.line_number}" do
      raise failure.message
    end
  end
end