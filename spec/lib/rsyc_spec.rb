require 'spec_helper'

describe Rsyc::Config do

  subject { described_class.new FIXTURE_PATH.join("app.yml"), "test" }

  it 'should load configuration' do
    expect(subject).to be_a(Rsyc::Options)
  end

  it 'should fail when file is missing' do
    expect {
      described_class.new FIXTURE_PATH.join("missing.yml"), "test"
    }.to raise_error(ArgumentError)
  end

  it 'should fail when config is missing' do
    expect {
      described_class.new FIXTURE_PATH.join("blank.yml"), "test"
    }.to raise_error(ArgumentError)
  end

  it 'should fail when env is missing' do
    expect {
      described_class.new FIXTURE_PATH.join("app.yml"), "missing"
    }.to raise_error(ArgumentError)
  end

  it 'should have accessors' do
    expect(subject.simple).to eq("value")
    expect(subject[:simple]).to eq("value")
    expect(subject["simple"]).to eq("value")
    expect(subject.respond_to?(:simple)).to be_truthy
    expect(subject.respond_to?("simple")).to be_truthy

    expect { subject.missing }.to raise_error(NoMethodError)
    expect(subject[:missing]).to be_nil
    expect(subject["missing"]).to be_nil

    expect(subject.nested).to eq({"scope"=>"name", "url"=>"http://test.host.com/path?a=1"})
    expect(subject.nested.url).to eq("http://test.host.com/path?a=1")
    expect(subject.nested[:url]).to eq("http://test.host.com/path?a=1")
    expect(subject.nested["url"]).to eq("http://test.host.com/path?a=1")

    expect { subject.nested.missing }.to raise_error(NoMethodError)
    expect(subject.nested[:missing]).to be_nil
    expect(subject.nested["missing"]).to be_nil
    expect(subject.respond_to?(:missing)).to be_falsey
    expect(subject.respond_to?("missing")).to be_falsey
  end

end

describe Rsyc::Options do

  subject { described_class.new some: "value", nested: { "status" => :ok } }

  it { is_expected.to be_a(Hash) }
  it { is_expected.to eq({"some"=>"value", "nested"=>{"status"=>:ok}}) }

  its(:some)    { should == "value" }
  its(["some"]) { should == "value" }
  its([:some])  { should == "value" }
  its(:nested)  { should be_instance_of(described_class) }

end
