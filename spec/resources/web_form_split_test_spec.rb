require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AWeber::Resources::WebFormSplitTest do
  include BaseObjects
  subject { aweber.account.lists[1].web_form_split_tests[1242668124] }
  
  it { should respond_to :components_collection_link }
  it { should respond_to :http_etag }
  it { should respond_to :id }
  it { should respond_to :is_active }
  it { should respond_to :name }
  it { should respond_to :resource_type_link }
  it { should respond_to :self_link }
end
