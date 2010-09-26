module AWeber
  module Resources
    class Subscriber < Resource
      attr_reader :ad_tracking
      attr_reader :add_ip
      attr_reader :add_method
      attr_reader :add_url
      attr_reader :email
      attr_reader :is_verified
      attr_reader :last_followup_sent_at
      attr_reader :last_followup_sent_link
      attr_reader :misc_notes
      attr_reader :name
      attr_reader :status
      attr_reader :subscribed_at
      attr_reader :unsubscribed_at
      attr_reader :verified_at
    
      alias_attribute :is_verified?, :is_verified
      alias_attribute :notes, :misc_notes
    end
  end
end