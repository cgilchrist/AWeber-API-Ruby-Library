module AWeber
  module Resources
    class Broadcast < Resource
      attr_reader :click_tracking_enabled
      attr_reader :content_type
      attr_reader :is_archived
      attr_reader :scheduled_at
      attr_reader :sent_at
      attr_reader :spam_assassin_score
      attr_reader :subject
      attr_reader :total_clicks
      attr_reader :total_opens
      attr_reader :total_sent
      attr_reader :total_spam_complaints
      attr_reader :total_undelivered
      attr_reader :total_unsubscribes
      attr_reader :twitter_account_link

      attr_reader :links_collection_link
      attr_reader :messages_collection_link

      has_many :links
      has_many :messages

      alias_attribute :is_archived?, :is_archived
      alias_attribute :is_click_tracking_enabled?, :click_tracking_enabled
    end
  end
end