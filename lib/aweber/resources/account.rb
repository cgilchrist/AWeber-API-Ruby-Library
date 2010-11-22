module AWeber
  module Resources
    class Account < Resource
      attr_reader :lists_collection_link
      attr_reader :integrations_collection_link
    
      has_many :lists
      has_many :integrations
    
      alias_attribute :etag, :http_etag
      alias_attribute :uri, :self_link
    end
  end
end