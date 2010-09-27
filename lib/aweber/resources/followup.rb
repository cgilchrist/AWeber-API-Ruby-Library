module AWeber
  module Resources
    class Followup < Resource
      attr_reader :click_tracking_enabled
      attr_reader :content_type
      attr_reader :message_interval
      attr_reader :message_number
      attr_reader :send_windows_enabled
      attr_reader :spam_assassin_score
      attr_reader :subject
      attr_reader :total_clicked
      attr_reader :total_complaints
      attr_reader :total_opened
      attr_reader :total_sent
      attr_reader :total_undeliverable
      attr_reader :total_unsubscribed
      
      attr_reader :links_collection_link
      attr_reader :messages_collection_link
      
      has_many :links
      has_many :messages
    end
  end
end