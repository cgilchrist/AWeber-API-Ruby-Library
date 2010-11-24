require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AWeber::Resources::Click do
  include BaseObjects
  subject { aweber.account.lists[1].campaigns[50000047].links[136340].clicks[129530] }
  
  it { should respond_to :event_time }
  it { should respond_to :http_etag }
  it { should respond_to :id }
  it { should respond_to :is_earliest }
  it { should respond_to :resource_type_link }
  it { should respond_to :self_link }
  it { should respond_to :subscriber_link }
end
