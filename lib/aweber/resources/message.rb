module AWeber
  module Resources
    class Message < Resource
      attr_reader :event_time
      attr_reader :last_opened
      attr_reader :total_opens
      
      attr_reader :subscriber_link
      attr_reader :tracked_events_collection_link
      attr_reader :opens_collection_link
      
      has_one :subscriber
      
      has_many :tracked_events
      has_many :opens
      
      alias_attribute :events, :tracked_events
    end
  end
end