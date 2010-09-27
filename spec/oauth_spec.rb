require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe AWeber::OAuth do
  
  it "initialize with consumer token and secret" do
    aweber = AWeber::OAuth.new('token', 'secret')
    aweber.consumer.key.should == 'token'
    aweber.consumer.secret.should == 'secret'
  end
  
  it "should create a consumer" do
    OAuth::Consumer.should_receive(:new).with('token', 'secret', {
      :site               => AWeber.auth_endpoint,
      :request_token_path => "/1.0/oauth/request_token",
      :authorize_path     => "/1.0/oauth/authorize",
      :access_token_path  => "/1.0/oauth/access_token",
      :scheme             => :query_string
    })
    
    AWeber::OAuth.new('token', 'secret').consumer
  end

  it "should set the request token path to /1.0/oauth/request_token" do
    aweber = AWeber::OAuth.new('token', 'secret')
    aweber.consumer.request_token_path.should == "/1.0/oauth/request_token"
  end

  it "should set the authorize path to /1.0/oauth/authorize" do
    aweber = AWeber::OAuth.new('token', 'secret')
    aweber.consumer.authorize_path.should == "/1.0/oauth/authorize"
  end

  it "should set the access token path to /1.0/oauth/access_token" do
    aweber = AWeber::OAuth.new('token', 'secret')
    aweber.consumer.access_token_path.should == "/1.0/oauth/access_token"
  end
  
  it "should get a request token from the consumer" do
    consumer = double('oauth consumer')
    rtoken   = double('request token')
    consumer.stub(:get_request_token) { rtoken }
    OAuth::Consumer.stub(:new) { consumer }
    
    aweber = AWeber::OAuth.new('token', 'secret')
    aweber.request_token.should == rtoken
  end
  
  it "should set the callback url" do
    oauth = AWeber::OAuth.new('token', 'secret', :callback_url => "http://example.com")
    oauth.callback_url.should == "http://example.com"
  end
  
  it "should be able to authorize with a verifier code" do
    consumer = double('oauth consumer')
    rtoken   = double('request token')
    atoken   = double('access token', :token => 'fake', :secret => 'fake')
    
    consumer.stub(:get_request_token) { rtoken }
    rtoken.stub(:get_access_token)    { atoken }
    OAuth::Consumer.stub(:new)        { consumer }
    OAuth::AccessToken.stub(:new)     { atoken }
    
    rtoken.should_receive(:get_access_token).with({ :oauth_verifier => 'fake' })
    aweber = AWeber::OAuth.new('token', 'secret')
    aweber.authorize_with_verifier('fake')
    aweber.access_token.should == atoken
  end
  
  it "should able to create access tokens from access token key and secret" do
    aweber = AWeber::OAuth.new('token', 'secret')
    aweber.authorize_with_access('atoken', 'asecret')
    
    aweber.access_token.should be_an OAuth::AccessToken
    aweber.access_token.token.should == 'atoken'
    aweber.access_token.secret.should == 'asecret'
  end
  
  it "should delegate get to access token" do
    atoken = double('access token')
    aweber = AWeber::OAuth.new('token', 'secret')
    aweber.stub(:access_token) { atoken }
    
    atoken.should_receive(:get).and_return(nil)
    aweber.get("/foo")
  end
  
  it "should delegate post to access token" do
    atoken = double('access token')
    aweber = AWeber::OAuth.new('token', 'secret')
    aweber.stub(:access_token) { atoken }
    
    atoken.should_receive(:post).and_return(nil)
    aweber.post("/foo")
  end

end
