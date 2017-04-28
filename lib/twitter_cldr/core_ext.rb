# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

if RUBY_VERSION >= '2.4.0'
  [Integer, Float].each do |klass|
    TwitterCldr::Localized::LocalizedNumber.localize(klass)
  end
else
  [Bignum, Fixnum, Float].each do |klass|
    TwitterCldr::Localized::LocalizedNumber.localize(klass)
  end
end

[Array, Date, DateTime, String, Symbol, Time, Hash].each do |klass|
  TwitterCldr::Localized::const_get("Localized#{klass}").localize(klass)
end
