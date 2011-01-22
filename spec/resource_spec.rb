require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class FakeResource < AWeber::Resource
  attr_accessor :foo
  api_attr :name, :writable => true
  alias_attribute :bar, :foo
  has_many :lists
end

describe AWeber::Resource do
  
  before :each do
    @oauth  = AWeber::OAuth.new("token", "secret")
    @aweber = AWeber::Base.new(@oauth)
  end
  
  it "should alias attributes" do
    fake = FakeResource.new(@aweber)
    fake.foo = "abc"
    fake.bar.should == "abc"
  end
  
  it "should create collections" do
    @aweber.stub(:expand) { "https://api.aweber.com/1.0/accounts/1/lists" }
    fake = FakeResource.new(@aweber)
    fake.lists.should be_an AWeber::Collection
  end
  
  it "should have the standard resource attributes" do
    fake = FakeResource.new(@aweber)
    fake.should respond_to :id
    fake.should respond_to :http_etag
    fake.should respond_to :self_link
    fake.should respond_to :resource_type_link
  end
  
  it "should be creatable from data" do
    fake = FakeResource.new @aweber, :id => 1, :http_etag => "a1b2c3", 
      :self_link => "foo", :resource_type_link => "bar"
    fake.id.should == 1
    fake.http_etag.should == "a1b2c3"
    fake.self_link.should == "foo"
    fake.resource_type_link.should == "bar"
  end
  
  it "should have simpler aliases for the standard attributes" do
    fake = FakeResource.new @aweber, :id => 1, :http_etag => "a1b2c3",
      :self_link => "foo", :resource_type_link => "bar"
    fake.etag.should == "a1b2c3"
    fake.link.should == "foo"
    fake.resource_type.should == "bar"
  end
  
  it "should be comparable to other resources based on id" do
    fake1 = FakeResource.new @aweber, :id => 1
    fake2 = FakeResource.new @aweber, :id => 1
    fake3 = FakeResource.new @aweber, :id => 2
    fake1.should == fake2
    fake1.should_not == fake3
  end
  
  it "should be deleted" do
    fake = FakeResource.new(@aweber, ActiveSupport::JSON.decode(fixture("account.json")))
    @oauth.should_receive(:delete).with(fake.link)
    fake.delete
  end
  
  it "should declare writable attributes" do
    resource = FakeResource.new(@aweber)
    resource.writable_attrs.include?(:name).should be_true
  end
  
  it "should send a JSON respresentation of the object on save" do
    resource = FakeResource.new(@aweber)
    @oauth.should_receive(:put).with(resource.link, "{\"name\":\"Bob\"}")
    resource.name = "Bob"
    resource.save
  end
  
end
