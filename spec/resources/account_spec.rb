require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AWeber::Resources::Account do
  include BaseObjects
  subject { aweber.account }
  
  it { should respond_to :id }
  it { should respond_to :http_etag }
  it { should respond_to :self_link }
  it { should respond_to :resource_type_link }
  it { should respond_to :lists_collection_link }
  it { should respond_to :integrations_collection_link }
end
