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

    def_delegators :client, :get

    class << self
      # Works the same as +alias_method+, but for attributes created via
      # +attr*+ methods.
      #
      def alias_attribute(alias_, attribute)
        alias_method alias_, attribute
      end
      
      def has_one(name)
        define_method(name) do
          ivar = instance_variable_get("@#{name}")
          return instance_var if instance_var
          
          resource_link = instance_variable_get("@#{name}_link")
          klass         = AWeber.get_class("#{name}s")
          collection    = Collection.new(client, klass, get(resource_link))
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
          collection    = Collection.new(client, klass, get(resource_link))
          instance_variable_set("@#{name}", collection)
        end
      end
    end

    attr_reader :id
    attr_reader :http_etag
    attr_reader :self_link
    attr_reader :resource_type_link

    alias_attribute :etag, :http_etag
    alias_attribute :link, :self_link
    alias_attribute :resource_type, :resource_type_link

    def initialize(client, data={})
      @client = client
      data.each do |key, value|
        instance_variable_set("@#{key}", value) if respond_to? key
      end
    end

    def <=>(other)
      @id <=> other.id
    end
    
    def inspect
      "#<#{self.class} id=\"#{@id}\">"
    end

  private

    def client
      @client
    end

  end
end