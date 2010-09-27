module AWeber
  module Resources
    class Account < Resource
      attr_reader :lists_collection_link
      attr_reader :vendor_accounts_collection_link
      
      has_many :lists
      has_many :vendor_accounts
      
      alias_attribute :etag, :http_etag
      alias_attribute :uri, :self_link
      alias_attribute :resource_type, :resource_type_link
    end
  end
end