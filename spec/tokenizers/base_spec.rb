# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

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
    @base = TwitterCldr::Tokenizers::Base.new  # do NOT do this in production - must use subclass
  end

  it "should use English locale by default" do
    @base.locale.should == :en
  end

  it "should use provided locale if there is one" do
    TwitterCldr::Tokenizers::Base.new(:locale => :de).locale.should == :de
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
      mock(@base).traverse([:another, :path]) { "found_me" }
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

  describe "#tokens_for" do
    let(:token1) { Token.new(:value => "token1", :type => :plaintext) }
    let(:token2) { Token.new(:value => "token2", :type => :plaintext) }

    before(:each) do
      stub(@base).traverse([:fake_key]) { "fake_pattern" }
      stub(@base).pattern_for("fake_pattern") { "fake_expandable_pattern" }
      stub(@base).expand_pattern("fake_expandable_pattern", "fake_type") { [token1, token2] }
    end

    it "caches tokens" do
      result = @base.send(:tokens_for, [:fake_key], "fake_type")
      result[0].value.should == "token1"
      result[1].value.should == "token2"
      @base.class.send(:class_variable_get, :'@@token_cache')["en|fake_key|fake_type".hash].should == result

      result_again = @base.send(:tokens_for, [:fake_key], "fake_type")
      result_again.object_id.should == result.object_id
    end

    it "caches tokens per language" do
      result_en = @base.send(:tokens_for, [:fake_key], "fake_type")
      result_en[0].value.should == "token1"
      result_en[1].value.should == "token2"
      @base.class.send(:class_variable_get, :'@@token_cache')["en|fake_key|fake_type".hash].should == result_en
      result_en2 = @base.send(:tokens_for, [:fake_key], "fake_type")
      result_en2.object_id.should == result_en.object_id

      @base.instance_variable_set(:'@locale', :pt)
      result_pt = @base.send(:tokens_for, [:fake_key], "fake_type")
      result_pt[0].value.should == "token1"
      result_pt[1].value.should == "token2"
      @base.class.send(:class_variable_get, :'@@token_cache')["pt|fake_key|fake_type".hash].should == result_pt
      result_pt.object_id.should_not == result_en.object_id
      result_pt2 = @base.send(:tokens_for, [:fake_key], "fake_type")
      result_pt2.object_id.should == result_pt.object_id
      result_pt2.object_id.should_not == result_en.object_id
      result_pt2.object_id.should_not == result_en2.object_id
    end
  end

  describe "#expand" do
    it "leaves a normal hash alone" do
      hash = { :twitter => { :is => "cool" } }
      @base.send(:expand, hash, hash).should == hash
    end

    it "expands a single symbol path" do
      hash = { :twitter => { :is => :'adjective.positive' }, :adjective => { :positive => "cool" } }
      @base.send(:expand, hash, hash).should == { :twitter => { :is => "cool" }, :adjective => { :positive => "cool" } }
    end

    it "expands nested symbol paths" do
      hash = { :twitter => { :is => :'adjective.positive' }, :adjective => { :positive => :'adjective.default', :default => "awesome" } }
      @base.send(:expand, hash, hash).should == { :twitter => { :is => "awesome" }, :adjective => { :positive => "awesome", :default => "awesome" } }
    end
  end

  describe "#traverse" do
    before(:each) do
      @tree = { :admiral => { :captain => { :commander => { :lieutenant => "Found Me!" } } } }
    end

    it "should find the correct value in the hash" do
      @base.send(:traverse, [:admiral, :captain, :commander, :lieutenant], @tree).should == "Found Me!"
    end

    it "shouldn't choke if the path doesn't exist" do
      @base.send(:traverse, [:admiral, :captain, :commander, :lieutenant, :ensign], @tree).should == nil
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