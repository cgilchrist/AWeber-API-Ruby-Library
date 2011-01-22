require "forwardable"
require "oauth"

module AWeber
  API_VERSION  = "1.0".freeze
  AUTH_VERSION = "1.0".freeze
  
  # Used for +has_many+ and +has_one+ relationships.
  # 
  INFLECTIONS  = { 
    :accounts             => :Account,
    :clicks               => :Click,
    :links                => :Link,
    :lists                => :List,
    :messages             => :Message,
    :opens                => :Open,
    :subscribers          => :Subscriber,
    :tracked_events       => :TrackedEvent,
    :integrations         => :Integration,
    :web_forms            => :WebForm,
    :components           => :WebFormSplitTestComponent,
    :web_form_split_tests => :WebFormSplitTest,
    :last_followup_sents  => :Followup
  }
  
  class << self
    # @param [String] Base URL of the API server
    #
    attr_accessor :api_endpoint
    
    # @param [String] Base URL of the Auth server
    #
    attr_accessor :auth_endpoint
    
    def api_url
      File.join api_endpoint, API_VERSION
    end
    
    def auth_url
      File.join auth_endpoint, AUTH_VERSION
    end
    
    # Retrieves the Resource class based on the 
    # +INFLECTIONS+ map and +name+.
    #
    # @param [Symbol] name Collection name
    #
    def get_class(name)
      Resources.const_get(INFLECTIONS[name])
    end
  end
  
  @api_endpoint  = "https://api.aweber.com"
  @auth_endpoint = "https://auth.aweber.com"
  
  class OAuthError < Exception; end
  class NotFoundError < Exception; end
  class UnknownRequestError < Exception; end
end

$LOAD_PATH << File.dirname(__FILE__) unless $LOAD_PATH.include?(File.dirname(__FILE__))
require "aweber/oauth"
require "aweber/base"
require "aweber/resource"
require "aweber/resources"
require "aweber/collection"
