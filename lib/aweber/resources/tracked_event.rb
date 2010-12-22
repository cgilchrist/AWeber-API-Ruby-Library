module AWeber
  module Resources
    class TrackedEvent < Resource
      api_attr :event_time
      api_attr :type
      api_attr :subscriber_link
      
      has_one :subscriber
    
      alias_attribute :time, :event_time
    end
  end
end