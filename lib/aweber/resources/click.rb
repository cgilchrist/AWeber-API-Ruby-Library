module AWeber
  module Resources
    class Click < Resource
      attr_reader :event_time
      attr_reader :is_earliest
      attr_reader :subscriber_link
      
      has_one :subscriber
      
      alias_attribute :is_earliest?, :is_earliest
    end
  end
end