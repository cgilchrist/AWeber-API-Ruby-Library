module AWeber
  module Resources
    class Broadcast < Resource
      attr_reader :click_tracking_enabled
      attr_reader :content_type
      attr_reader :published_to_archive
      attr_reader :send_date
      attr_reader :sent_date
      attr_reader :spam_assassin_score
      attr_reader :subject
      attr_reader :total_clicks
      attr_reader :total_complaints
      attr_reader :total_opens
      attr_reader :total_sent
      attr_reader :total_undeliverable
      attr_reader :total_unsubscribed
      attr_reader :twitter_account_link
      
      attr_reader :links_collection_link
      attr_reader :messages_collection_link
      
      has_many :links
      has_many :messages
      
      alias_attribute :is_click_tracked?, :click_tracking_enabled
      alias_attribute :sent_at, :sent_date
    end
  end
end