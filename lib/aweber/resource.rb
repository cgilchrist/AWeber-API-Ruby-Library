module AWeber
  # Base class for all entries. All resources have the following attributes:
  #
  # - +id+
  # - +http_etag+ (aliased as +etag+)
  # - +self_link+ (aliased as +link+)
  # - +resource_type_link+ (aliased as +resource_type+)
  #
  # Resources also have attributes based on their the type of resource it is.
  # To see a full list of attributes per resource, visit
  # http://labs.aweber.com/docs/reference/1.0/reference.
  #
  class Resource
    extend Forwardable
    include Comparable

    class << self
      attr_accessor :writable_attrs
      # Works the same as +alias_method+, but for attributes created via
      # +attr*+ methods.
      #
      def alias_attribute(alias_, attribute)
        alias_method alias_, attribute
      end
      
      # Defines an attribute that it either read only or writable.
      # 
      # == Example:
      # 
      #   # Read-only
      #   api_attr :name
      # 
      #   # Writable
      #   api_attr :name, :writable => true
      # 
      # If an attribute is writable it will be sent with the request when
      # +save+ is called.
      # 
      def api_attr(attr_, opts={})
        if opts[:writable]
          attr_accessor attr_
          @writable_attrs ||= []
          @writable_attrs << attr_
        else
          attr_reader attr_
        end
      end
      
      def has_one(name)
        define_method(name) do
          ivar = instance_variable_get("@#{name}")
          return ivar if ivar
          
          resource_link = instance_variable_get("@#{name}_link")
          klass         = AWeber.get_class(:"#{name}s")
          collection    = klass.new(client, client.get(resource_link))
          instance_variable_set("@#{name}", collection)
        end
      end

      # Creates a lazy loaded method which will retrieve and create a 
      # collection of +name+ of objects.
      #
      # @param [Symbol] name name of the collection method
      # @return [AWeber::Collection] Collection of +name+ objects
      #
      # @example
      #   class Account
      #     attr_reader :lists_collection_link
      #     collection  :lists
      #   end
      #
      #   #=> Account.new(...).lists #=> <AWeber::Collection>
      #
      def has_many(name)
        define_method(name) do
          ivar = instance_variable_get("@#{name}")
          return ivar if ivar

          resource_link = instance_variable_get("@#{name}_collection_link")
          klass         = AWeber.get_class(name)
          collection    = Collection.new(client, klass, client.get(resource_link))
          instance_variable_set("@#{name}", collection)
        end
      end
    end

    api_attr :id
    api_attr :http_etag
    api_attr :self_link
    api_attr :resource_type_link

    alias_attribute :etag, :http_etag
    alias_attribute :link, :self_link
    alias_attribute :resource_type, :resource_type_link

    def initialize(client, data={})
      @client = client
      data.each do |key, value|
        instance_variable_set("@#{key}", value) if respond_to? key
      end
    end
    
    def delete
      client.delete(@self_link)
    end
    
    def save
      body = writable_attrs.inject({}) do |body, attr_|
        body[attr_] = send(attr_)
        body
      end
      client.put(self_link, body)
    end
    
    def writable_attrs
      self.class.writable_attrs ||= {}
    end

    def <=>(other)
      @id <=> other.id
    end

  private

    def client
      @client
    end

  end
end