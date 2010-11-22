module AWeber
  module Resources
    class Subscriber < Resource
      attr_reader :ad_tracking
      attr_reader :email
      attr_reader :ip_address
      attr_reader :is_verified
      attr_reader :last_followup_sent_at
      attr_reader :misc_notes
      attr_reader :name
      attr_reader :status
      attr_reader :subscribed_at
      attr_reader :subscription_method
      attr_reader :subscription_url
      attr_reader :unsubscribed_at
      attr_reader :verified_at
      
      attr_reader :last_followup_sent_link
      
      has_one :last_followup_sent
      
      alias_attribute :is_verified?, :is_verified
      alias_attribute :notes, :misc_notes
    end
  end
end