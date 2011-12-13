require File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "spec_helper")
include TwitterCldr

describe Time do
  describe "#localize" do
    it "should localize with the given locale, English by default" do
      time = Time.now
      loc_time = time.localize
      loc_time.should be_a(LocalizedTime)
      loc_time.locale.should == :en
      loc_time.base_obj.should == time

      loc_time = Time.now.localize(:it)
      loc_time.should be_a(LocalizedTime)
      loc_time.locale.should == :it
    end
  end
end

describe LocalizedTime do
  describe "#to_custom_s" do
    it "should call the corresponding formatter function" do
      time = Time.now.localize(:it)
      mock(time.formatter).format(time.base_obj, :type => :albatross) { "" }
      time.to_albatross_s
    end
  end
end