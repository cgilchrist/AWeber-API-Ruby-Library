require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AWeber::Resources::Message do
  include BaseObjects
  subject { aweber.account.lists[1] }
  
  it { should respond_to :campaigns_collection_link }
  it { should respond_to :http_etag }
  it { should respond_to :id }
  it { should respond_to :name }
  it { should respond_to :resource_type_link }
  it { should respond_to :self_link }
  it { should respond_to :subscribers_collection_link }
  it { should respond_to :web_form_split_tests_collection_link }
  it { should respond_to :web_forms_collection_link }
  it { should respond_to :broadcasts }
  it { should respond_to :followups }
  
  it "should should have a collection of broadcasts" do
    subject.broadcasts.map { |id, b| b.self_link }.all? { |b| b =~ /b\d+$/ }.should be_true
  end
  
  it "should should have a collection of followups" do
    subject.followups.map { |id, f| f.self_link }.all? { |f| f =~ /f\d+$/ }.should be_true
  end
end
