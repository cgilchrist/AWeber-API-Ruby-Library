require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AWeber::Resources::Link do
  include BaseObjects
  subject { aweber.account.lists[1].campaigns[50000047].links[136340] }
  
  it { should respond_to :clicks_collection_link }
  it { should respond_to :http_etag }
  it { should respond_to :id }
  it { should respond_to :resource_type_link }
  it { should respond_to :self_link }
  it { should respond_to :total_clicks }
  it { should respond_to :total_unique_clicks }
  it { should respond_to :url }
end
