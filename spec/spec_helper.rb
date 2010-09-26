$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require "aweber"
require "fakeweb"
require 'rspec'

FakeWeb.allow_net_connect = false
FakeWeb.register_uri(:any, "https://auth.aweber.com/1.0/request_token",
  :body => "oauth_token=fake&oauth_token_secret=fake")
FakeWeb.register_uri(:any, "https://auth.aweber.com/1.0/access_token",
  :body => "oauth_token=fake&oauth_token_secret=fake")

def aweber_url(url)
  url =~ /https/ ? url : File.join(AWeber.api_endpoint, "1.0", url)
end

def route(method, uri, response)
  FakeWeb.register_uri(method, uri, :body => response)
end

def fixture(filename)
  return "" if filename.empty?
  path = File.expand_path(File.dirname(__FILE__) + "/fixtures/" + filename)
  File.read(path).gsub /\s/, ''
end

def stub_get(uri, response)
  route(:get, uri, fixture(response))
end

route :get, %r|/accounts/\d+\?|, fixture("account.json")
route :get, %r|/accounts\?|,     fixture("accounts.json")

route :get, %r|/accounts/\d+/lists\?|,       fixture("lists_page_1.json")
route :get, %r|/accounts/\d+/lists/page2\?|, fixture("lists_page_2.json")