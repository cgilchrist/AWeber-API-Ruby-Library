module AWeber
  module Resources
    class Open < Resource
      attr_reader :event_time
      attr_reader :subscriber_link
      
      has_one :subscriber
    end
  end
end