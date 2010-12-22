module AWeber
  module Resources
    class Open < Resource
      api_attr :event_time
      api_attr :subscriber_link
      
      has_one :subscriber
    end
  end
end