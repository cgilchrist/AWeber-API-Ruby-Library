module AWeber
  module Resources
    class Link < Resource
      attr_reader :total_clicks
      attr_reader :total_unique_clicks
      attr_reader :url
      attr_reader :clicks_collection_link
      
      has_many :clicks
    end
  end
end