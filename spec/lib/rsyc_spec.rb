require 'spec_helper'

describe Rsyc::Config do

  subject { described_class.new FIXTURE_PATH.join("app.yml"), "test" }

  it 'should load configuration' do
    subject.should be_a(Rsyc::Options)
  end

  it 'should fail when file is missing' do
    -> {
      described_class.new FIXTURE_PATH.join("missing.yml"), "test"
    }.should raise_error(ArgumentError)
  end

  it 'should fail when config is missing' do
    -> {
      described_class.new FIXTURE_PATH.join("blank.yml"), "test"
    }.should raise_error(ArgumentError)
  end

  it 'should fail when env is missing' do
    -> {
      described_class.new FIXTURE_PATH.join("app.yml"), "missing"
    }.should raise_error(ArgumentError)
  end

  it 'should have accessors' do
    subject.simple.should == "value"
    subject[:simple].should == "value"
    subject["simple"].should == "value"
    subject.respond_to?(:simple).should be_true
    subject.respond_to?("simple").should be_true

    -> { subject.missing }.should raise_error(NoMethodError)
    subject[:missing].should be_nil
    subject["missing"].should be_nil

    subject.nested.should == {"scope"=>"name", "url"=>"http://test.host.com/path?a=1"}
    subject.nested.url.should == "http://test.host.com/path?a=1"
    subject.nested[:url].should == "http://test.host.com/path?a=1"
    subject.nested["url"].should == "http://test.host.com/path?a=1"

    -> { subject.nested.missing }.should raise_error(NoMethodError)
    subject.nested[:missing].should be_nil
    subject.nested["missing"].should be_nil
    subject.respond_to?(:missing).should be_false
    subject.respond_to?("missing").should be_false
  end

end

describe Rsyc::Options do

  subject { described_class.new some: "value", nested: { "status" => :ok } }

  it { should be_a(Hash) }
  it { should == {"some"=>"value", "nested"=>{"status"=>:ok}} }

  its(:some)    { should == "value" }
  its(["some"]) { should == "value" }
  its([:some])  { should == "value" }
  its(:nested)  { should be_instance_of(described_class) }

end
