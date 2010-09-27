module AWeber
  class OAuth
    extend Forwardable

    def_delegators :access_token, :get, :post, :put, :delete

    attr_accessor :callback_url

    def initialize(consumer_token, consumer_secret, options={})
      @consumer_token  = consumer_token
      @consumer_secret = consumer_secret
      @callback_url    = options[:callback_url]
    end

    def consumer
      @consumer ||= ::OAuth::Consumer.new(@consumer_token, @consumer_secret, {
        :site               => AWeber.auth_endpoint,
        :request_token_path => "/#{AWeber::AUTH_VERSION}/oauth/request_token",
        :authorize_path     => "/#{AWeber::AUTH_VERSION}/oauth/authorize",
        :access_token_path  => "/#{AWeber::AUTH_VERSION}/oauth/access_token",
        :scheme             => :query_string
      })
    end

    # Retrieve a Request Token or simply return it, if it already exists.
    #
    # @param [Hash] options OAuth parameters. +:oauth_callback+ for example
    #
    def request_token(options={})
      @request_token ||= consumer.get_request_token(options)
    end

    # Get an Access Token from a Request Token using the 
    # +verifier+ code.
    #
    # @param [String] verifier Verification code retrieved from 
    #                          user authentication
    #
    def authorize_with_verifier(verifier)
      token = request_token.get_access_token(:oauth_verifier => verifier)
      @access_token_key    = token.token
      @access_token_secret = token.secret
      access_token
    end

    def access_token
      @access_token ||= ::OAuth::AccessToken.new(consumer, @access_token_key,
        @access_token_secret)
    end

    # Authorize with an Access Token key and secret you've previously
    # retrieved via a user authentication.
    #
    # @param [String] access_token_key Access Token key
    # @param [String] access_token_secret Access Token secret
    #
    def authorize_with_access(access_token_key, access_token_secret)
      @access_token_key    = access_token_key
      @access_token_secret = access_token_secret
    end

    # Remove any active token instances and start over
    #
    def clear_tokens
      @request_token = nil
      @access_token  = nil
    end
  end
end