# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe ImplicitCollationElements do

  it 'computes correct implicit value for non-CJK code points' do
    expect(ImplicitCollationElements.for_code_point(0xD801)).to  eq([[0xE305C758, 0x5, 0x5]])
    expect(ImplicitCollationElements.for_code_point(0xC0001)).to eq([[0xE44E70AC, 0x5, 0x5]])
    expect(ImplicitCollationElements.for_code_point(0xFFF02)).to eq([[0xE4C25F74, 0x5, 0x5]])
  end

  it 'computes correct implicit values for CJK code points' do
    expect(ImplicitCollationElements.for_code_point(0x4E00)).to  eq([[0xE00406, 0x5, 0x5]])
    expect(ImplicitCollationElements.for_code_point(0x3400)).to  eq([[0xE0ABCE, 0x5, 0x5]])
    expect(ImplicitCollationElements.for_code_point(0x20000)).to eq([[0xE1302590, 0x5, 0x5]])
  end

end
