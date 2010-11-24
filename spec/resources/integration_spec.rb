require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AWeber::Resources::Integration do
  include BaseObjects
  subject { aweber.account.integrations[8076] }
  
  it { should respond_to :http_etag }
  it { should respond_to :id }
  it { should respond_to :login }
  it { should respond_to :resource_type_link }
  it { should respond_to :self_link }
  it { should respond_to :service_name }
end
