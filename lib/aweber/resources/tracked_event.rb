module AWeber
  module Resources
    class TrackedEvent < Resource
      attr_reader :event_time
      attr_reader :subscriber_link
      attr_reader :type
    
      alias_attribute :time, :event_time
    end
  end
end