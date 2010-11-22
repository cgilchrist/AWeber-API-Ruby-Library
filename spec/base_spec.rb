require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe AWeber::Base do
  before :each do
    @oauth  = AWeber::OAuth.new("token", "secret")
    @aweber = AWeber::Base.new(@oauth)
  end
  
  it "should have an account" do
    @aweber.account.should be_an AWeber::Resources::Account
  end
  
  it "should expand uris to full paths" do
    resp = @oauth.get("https://api.aweber.com/1.0/accounts")
    @oauth.should_receive(:get).with("https://api.aweber.com/1.0/accounts").and_return(resp)
    @aweber.account
  end
  
  it "should delegate to the oauth object" do
    @oauth.should_receive(:get).with("https://api.aweber.com/1.0/foo")
    @aweber.send(:get, "/foo")
  end
end
