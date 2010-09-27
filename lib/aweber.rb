require "bundler"
Bundler.setup
require "forwardable"
require "oauth"
require "json/pure"

module AWeber
  API_VERSION  = "1.0".freeze
  AUTH_VERSION = "1.0".freeze
  
  # Collection name to Resources::CLASS map. Instead
  # of relying on the assumption that collections
  # are simply class names without the "s", we
  # explicitely set up a mapping from name to class.
  INFLECTIONS = { 
    :accounts        => :Account,
    :broadcasts      => :Broadcast,
    :clicks          => :Click,
    :followups       => :Followup,
    :links           => :Link,
    :lists           => :List,
    :messages        => :Message,
    :subscribers     => :Subscriber,
    :tracked_events  => :TrackedEvent,
    :vendor_accounts => :VendorAccount
  }
  
  class << self
    # @param [String] Base URL of the API server
    attr_accessor :api_endpoint
    
    # @param [String] Base URL of the Auth server
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
end

$:.unshift File.expand_path(File.dirname(__FILE__))
require "aweber/oauth"
require "aweber/base"
require "aweber/resource"
require "aweber/collection"
