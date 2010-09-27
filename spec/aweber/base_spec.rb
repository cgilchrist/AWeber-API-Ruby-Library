require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AWeber::Base do
  
  before :each do
    @oauth  = AWeber::OAuth.new("token", "secret")
    @aweber = AWeber::Base.new(@oauth)
  end
  
  it "should have an account" do
    puts @oauth.inspect
    base = AWeber::Base.new(@oauth)
    base.account.should be_an AWeber::Resources::Account
  end
  
  it "should expand uris to full paths" do
    base = AWeber::Base.new(@oauth)
    resp = @oauth.get("https://api.aweber.com/1.0/accounts")
    @oauth.should_receive(:get).with("https://api.aweber.com/1.0/accounts").and_return(resp)
    base.account
  end
  
  it "should delegate to the oauth object" do
    @oauth.should_receive(:get).with("https://api.aweber.com/1.0/foo")
    base = AWeber::Base.new(@oauth)
    base.send(:get, "/foo")
  end

end
