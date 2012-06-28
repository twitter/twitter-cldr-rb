# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr

describe "Numbers" do
  it "makes sure currency formatters for every locale don't raise errors" do
    TwitterCldr.supported_locales.each do |locale|
      lambda { 1337.localize(locale).to_currency.to_s }.should_not raise_error
      lambda { 1337.localize(locale).to_currency.to_s(:precision => 3) }.should_not raise_error
      lambda { 1337.localize(locale).to_currency.to_s(:precision => 3, :currency => "EUR") }.should_not raise_error
    end
  end

  it "makes sure decimal formatters for every locale don't raise errors" do
    TwitterCldr.supported_locales.each do |locale|
      lambda { 1337.localize(locale).to_decimal.to_s }.should_not raise_error
      lambda { 1337.localize(locale).to_decimal.to_s(:precision => 3) }.should_not raise_error
    end
  end

  it "makes sure percentage formatters for every locale don't raise errors" do
    TwitterCldr.supported_locales.each do |locale|
      lambda { 1337.localize(locale).to_percent.to_s }.should_not raise_error
      lambda { 1337.localize(locale).to_percent.to_s(:precision => 3) }.should_not raise_error
    end
  end

  it "makes sure basic number formatters for every locale don't raise errors" do
    TwitterCldr.supported_locales.each do |locale|
      lambda { 1337.localize(locale).to_s }.should_not raise_error
      lambda { 1337.localize(locale).to_s(:precision => 3) }.should_not raise_error
    end
  end
end