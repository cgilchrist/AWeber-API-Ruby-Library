module AWeber
  class Base
    extend Forwardable
    
    def_delegators :client, :get, :post, :put, :delete
    attr_accessor  :debug
    attr_reader    :account
    
    def initialize(client)
      @debug     = false
      @client    = client
      AWeber.api = self
    end
    
    def accounts
      @accounts ||= Collection.new(Resources::Account, get_resource("/accounts"))
    end
    
  private
    
    def get_resource(uri)
      parse get(expand(uri))
    end
    
    def expand(uri)
      url = []
      parsed = URI.parse(uri)
      url << AWeber.api_endpoint unless parsed.host
      url << API_VERSION unless parsed.path.include? API_VERSION
      url << uri
      File.join(*url)
    end
  
    def parse(response)
      JSON.parse(response.body)
    end
    
    def client
      @client
    end
  end
end