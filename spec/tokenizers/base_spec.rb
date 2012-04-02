# encoding: UTF-8

require File.join(File.dirname(File.dirname(__FILE__)), "spec_helper")
include TwitterCldr::Tokenizers

# normally, base can't be instantiated, so we have to patch it here
module TwitterCldr
  module Tokenizers
    class Base
      def init_resources; end
    end
  end
end

describe Base do
  before(:each) do
    @base = Base.new  # do NOT do this in production - must use subclass
  end

  it "creating a new base without a locale should default to English, with a locale should not" do
    @base.locale.should == :en
    Base.new(:locale => :de).locale.should == :de
  end

  # tokenize_pattern is supposed to take a pattern found in the YAML resource files and break it into placeholders and plaintext.
  # Placeholders are delimited by single and double curly braces, plaintext is everything else.
  describe "#tokenize_pattern" do
    context "with double curlies (path names, essentially)" do
      it "should work with a placeholder only" do
        @base.send(:tokenize_pattern, "{{place}}").should == [{ :value => "{{place}}", :type => :placeholder }]
      end

      it "should work with two placeholders separated by a space" do
        @base.send(:tokenize_pattern, "{{first}} {{second}}").should == [{ :value => "{{first}}", :type => :placeholder },
                                                                         { :value => " ", :type => :plaintext },
                                                                         { :value => "{{second}}", :type => :placeholder }]
      end

      it "should work when surrounded by plaintext" do
        @base.send(:tokenize_pattern, "being {{totally}} awesome").should == [{ :value => "being ", :type => :plaintext },
                                                                              { :value => "{{totally}}", :type => :placeholder },
                                                                              { :value => " awesome", :type => :plaintext }]
      end
    end

    context "with single curlies (indexes)" do
      it "should work with a placeholder only" do
        @base.send(:tokenize_pattern, "{1}").should == [{ :value => "{1}", :type => :placeholder }]
      end

      it "should work with two placeholders separated by a space" do
        @base.send(:tokenize_pattern, "{0} {1}").should == [{ :value => "{0}", :type => :placeholder },
                                                            { :value => " ", :type => :plaintext },
                                                            { :value => "{1}", :type => :placeholder }]
      end

      it "should work when surrounded by plaintext" do
        @base.send(:tokenize_pattern, "only {1} dragon").should == [{ :value => "only ", :type => :plaintext },
                                                                    { :value => "{1}", :type => :placeholder },
                                                                    { :value => " dragon", :type => :plaintext }]
      end
    end
  end

  describe "#choose_placeholder" do
    before(:each) do
      @placeholders = [{ :name => "wallace", :object => "man" }, { :name => "gromit", :object => "dog" }]
    end

    it "should choose the correct named placeholder" do
      @base.send(:choose_placeholder, "{{wallace}}", @placeholders).should == "man"
      @base.send(:choose_placeholder, "{{gromit}}", @placeholders).should == "dog"
    end

    it "should choose the correct placeholder by array index" do
      @base.send(:choose_placeholder, "{0}", @placeholders).should == "man"
      @base.send(:choose_placeholder, "{1}", @placeholders).should == "dog"
    end
  end

  describe "#expand_pattern" do
    it "recursively calls expand_pattern if a symbol (keypath) is given" do
      mock(@base).traverse(:'another.path') { "found_me" }
      mock(@base).pattern_for("found_me") { "pattern_text" }
      mock.proxy(@base).expand_pattern("pattern_text", :fake_type)
      mock.proxy(@base).expand_pattern(:'another.path', :fake_type)
      @base.send(:expand_pattern, :'another.path', :fake_type).should == [{ :value => "pattern_text", :type => :plaintext }]
    end

    it "expands placeholders as necessary" do
      placeholder_obj = Object.new
      mock(placeholder_obj).tokens(:type => :man) { ["token1", "token2"] }
      @base.placeholders = [{ :name => "wallace", :object => placeholder_obj }]
      @base.send(:expand_pattern, "{{wallace}} rules", :man).should == ["token1", "token2", { :type => :plaintext, :value => " rules" }]
    end

    it "doesn't choke if the placeholder can't be found" do
      @base.placeholders = [{ :name => "gromit", :object => "dog" }]
      @base.send(:expand_pattern, "{{wallace}} rules", :man).should == [{ :type => :plaintext, :value => " rules" }]
    end
  end

  describe "#traverse" do
    before(:each) do
      @tree = { :admiral => { :captain => { :commander => { :lieutenant => "Found Me!" } } } }
    end

    it "should find the correct value in the hash" do
      @base.send(:traverse, :'admiral.captain.commander.lieutenant', @tree).should == "Found Me!"
    end

    it "shouldn't choke if the path doesn't exist" do
      @base.send(:traverse, :'admiral.captain.commander.lieutenant.ensign', @tree).should == nil
    end
  end

  # Not to be confused with tokenize_pattern, which pulls out placeholders.  Tokenize_format actually splits a completely
  # expanded format string into whatever parts are defined by the subclass's token type and token splitter regexes.
  describe "#tokenize_format" do
    it "assigns the right token types to the tokens" do
      stub(@base).token_splitter_regex { /([abc])/ }
      stub(@base).token_type_regexes { [{ :type => :a, :regex => /a/ },
                                        { :type => :b, :regex => /b/ },
                                        { :type => :c, :regex => /c/ },
                                        { :type => :plaintext, :regex => // }] }
      tokens = @base.send(:tokenize_format, "a b c")
      tokens.size.should == 5

      tokens[0].value.should == "a"; tokens[0].type.should == :a
      tokens[1].value.should == " "; tokens[1].type.should == :plaintext
      tokens[2].value.should == "b"; tokens[2].type.should == :b
      tokens[3].value.should == " "; tokens[3].type.should == :plaintext
      tokens[4].value.should == "c"; tokens[4].type.should == :c
    end
  end
end