module AWeber
  module Resources
    class Click < Resource
      api_attr :event_time
      api_attr :is_earliest
      api_attr :subscriber_link
      
      has_one :subscriber
      
      alias_attribute :is_earliest?, :is_earliest
    end
  end
end