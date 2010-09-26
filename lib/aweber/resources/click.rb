module AWeber
  module Resources
    class Click < Resource
      attr_reader :event_time
      attr_reader :is_earliest
      attr_reader :subscriber_link
    end
  end
end