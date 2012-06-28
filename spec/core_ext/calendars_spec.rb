# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe "Calendars" do
  it "makes sure datetime formatters for every locale don't raise errors" do
    TwitterCldr.supported_locales.each do |locale|
      DateTimeTokenizer::VALID_TYPES.each do |type|
        lambda { DateTime.now.localize(locale).send(:"to_#{type}_s") }.should_not raise_error
      end
    end
  end

  it "makes sure date formatters for every locale don't raise errors" do
    TwitterCldr.supported_locales.each do |locale|
      DateTimeTokenizer::VALID_TYPES.each do |type|
        lambda { Date.today.localize(locale).send(:"to_#{type}_s") }.should_not raise_error
      end
    end
  end

  it "makes sure time formatters for every locale don't raise errors" do
    TwitterCldr.supported_locales.each do |locale|
      DateTimeTokenizer::VALID_TYPES.each do |type|
        lambda { Time.now.localize(locale).send(:"to_#{type}_s") }.should_not raise_error
      end
    end
  end
end