module AWeber
  module Resources
    class Link < Resource
      api_attr :total_clicks
      api_attr :total_unique_clicks
      api_attr :url
      api_attr :clicks_collection_link
      
      has_many :clicks
    end
  end
end