module AWeber
  module Resources
    class Message < Resource
      api_attr :event_time
      api_attr :last_opened
      api_attr :total_opens

      api_attr :subscriber_link
      api_attr :tracked_events_collection_link
      api_attr :opens_collection_link
      
      has_one :subscriber
      
      has_many :tracked_events
      has_many :opens
      
      alias_attribute :events, :tracked_events
    end
  end
end