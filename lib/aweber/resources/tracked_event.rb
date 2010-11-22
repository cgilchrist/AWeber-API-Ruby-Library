module AWeber
  module Resources
    class TrackedEvent < Resource
      attr_reader :event_time
      attr_reader :type
      attr_reader :subscriber_link
      
      has_one :subscriber
    
      alias_attribute :time, :event_time
    end
  end
end