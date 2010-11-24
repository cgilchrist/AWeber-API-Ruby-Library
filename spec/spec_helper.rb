$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require "aweber"
require "fakeweb"
require 'rspec'

FakeWeb.allow_net_connect = false

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

module BaseObjects
  def oauth
    @oauth ||= AWeber::OAuth.new("token", "secret")
  end
  
  def aweber
    @aweber ||= AWeber::Base.new(oauth)
  end
end

route :any, "https://auth.aweber.com/1.0/request_token", "oauth_token=fake&oauth_token_secret=fake"
route :any, "https://auth.aweber.com/1.0/access_token",  "oauth_token=fake&oauth_token_secret=fake"

route :get, %r[/accounts\?], fixture("accounts.json")
route :get, %r[/accounts/\d+/lists\?], fixture("lists.json")
route :get, %r[/accounts/\d+/lists/\d+/subscribers\?], fixture("subscribers.json")
route :get, %r[/accounts/\d+/lists/\d+/web_forms\?], fixture("web_forms.json")
route :get, %r[/accounts/\d+/lists/\d+/web_form_split_tests\?], fixture("web_form_split_tests.json")
route :get, %r[/accounts/\d+/lists/\d+/web_form_split_tests/\d+/components\?], fixture("web_form_split_test_components.json")
route :get, %r[/accounts/\d+/integrations\?], fixture("integrations.json")
route :get, %r[/accounts/\d+/lists/\d+/campaigns\?], fixture("campaigns.json")
route :get, %r[/accounts/\d+/lists/\d+/campaigns/[\d\w]+/links\?], fixture("links.json")
route :get, %r[/accounts/\d+/lists/\d+/campaigns/[\d\w]+/links/\d+/clicks\?], fixture("clicks.json")
route :get, %r[/accounts/\d+/lists/\d+/campaigns/[\d\w]+/messages\?], fixture("messages.json")
route :get, %r[/accounts/\d+/lists/\d+/campaigns/[\d\w]+/messages/\d+/opens\?], fixture("opens.json")
route :get, %r[/accounts/\d+/lists/\d+/campaigns/[\d\w]+/messages/\d+/tracked_events\?], fixture("tracked_events.json")