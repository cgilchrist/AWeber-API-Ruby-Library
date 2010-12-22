require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AWeber::Resources::Subscriber do
  include BaseObjects
  subject { aweber.account.lists[1].subscribers[50723026] }
  
  it { should respond_to :ad_tracking }
  it { should respond_to :email }
  it { should respond_to :http_etag }
  it { should respond_to :id }
  it { should respond_to :ip_address }
  it { should respond_to :is_verified }
  it { should respond_to :last_followup_sent_at }
  it { should respond_to :last_followup_sent_link }
  it { should respond_to :misc_notes }
  it { should respond_to :name }
  it { should respond_to :resource_type_link }
  it { should respond_to :self_link }
  it { should respond_to :status }
  it { should respond_to :subscribed_at }
  it { should respond_to :subscription_method }
  it { should respond_to :subscription_url }
  it { should respond_to :unsubscribed_at }
  it { should respond_to :verified_at }
  
  its(:writable_attrs) { should include :name }
  its(:writable_attrs) { should include :misc_notes }
  its(:writable_attrs) { should include :email }
  its(:writable_attrs) { should include :status }
  its(:writable_attrs) { should include :custom_fields }
  its(:writable_attrs) { should include :ad_tracking }
  its(:writable_attrs) { should include :last_followup_message_number_sent }
end
