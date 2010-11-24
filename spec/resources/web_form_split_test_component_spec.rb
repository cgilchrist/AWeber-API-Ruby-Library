require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AWeber::Resources::WebFormSplitTestComponent do
  include BaseObjects
  subject { aweber.account.lists[1].web_form_split_tests[1242668124].components["612763163-513600765"] }
  
  it { should respond_to :conversion_percentage }
  it { should respond_to :http_etag }
  it { should respond_to :id }
  it { should respond_to :is_active }
  it { should respond_to :name }
  it { should respond_to :resource_type_link }
  it { should respond_to :self_link }
  it { should respond_to :total_displays }
  it { should respond_to :total_submissions }
  it { should respond_to :type }
  it { should respond_to :unique_conversion_percentage }
  it { should respond_to :web_form_link }
  it { should respond_to :weight }
end
