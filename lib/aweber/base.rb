module AWeber
  class Base

    def initialize(oauth)
      @oauth = oauth
    end

    def account
      accounts.first.last
    end
    
    def get(uri)
      response = oauth.get(expand(uri))
      handle_errors(response, uri)
      parse(response) if response
    end
    
    def delete(uri)
      oauth.delete(expand(uri))
    end
    
    def put(uri, body={})
      oauth.put(uri, body.to_json, {"Content-Type" => "application/json"})
    end

  private
    
    def handle_errors(response, uri)
      if response.is_a? Net::HTTPNotFound
        raise NotFoundError, "Invalid resource uri.", caller
      elsif response && response.body == "NotAuthorizedError"
        raise OAuthError, "Could not authorize OAuth credentials.", caller
      end
    end

    def accounts
      @accounts ||= Collection.new(self, Resources::Account, get("/accounts"))
    end

    def expand(uri)
      parsed = URI.parse(uri)
      url = []
      url << AWeber.api_endpoint
      url << API_VERSION unless parsed.path.include? API_VERSION
      url << parsed.path
      File.join(*url)
    end

    def parse(response)
      ActiveSupport::JSON.decode(response.body)
    end

    def oauth
      @oauth
    end
  end
end