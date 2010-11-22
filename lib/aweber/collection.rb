module AWeber
  # Collection objects are groups of Resources. Collections imitate
  # regular Hashes in most ways. You can access Resource by +id+ via the
  # +[]+ method.
  #
  #    lists    #=> #<AWeber::Collection ...>
  #    lists[1] #=> #<AWeber::Resources::List @id=1 ...>
  #
  # Also like Hashes, you can iterate over all of it's entries
  #
  #    lists.each { |id, list| puts list.name }
  #
  # Collections support dynamic +find_by_*+ methods, where +*+ is an
  # attribute and the first and only parameter is the value.
  #
  #    lists.find_by_name("testlist")
  #    #=> #<AWeber::Resources::List @id=123, @name="testlist" ...>
  #
  # +find_by_*+ methods will also return a Hash of entries if more than 
  # one matches the criteria. The hash will be keyed by resource ID.
  #
  #    messages.find_by_total_opens(0)
  #    #=> { "45697" => #<Message>, "12345" => #<Message> }
  #
  # Collections are paginated in groups of 20.
  #
  class Collection < Resource
    include Enumerable

    attr_reader :entries
    attr_reader :next_collection_link
    attr_reader :prev_collection_link
    attr_reader :resource_type_link
    attr_reader :total_size

    alias_method :size,   :total_size
    alias_method :length, :total_size

    # @param [AWeber::Base] client    Instance of AWeber::Base
    # @param [Class] klass            Class to create entries of
    # @param [Hash]  data             JSON decoded response data Hash
    #
    def initialize(client, klass, data={})
      super client, data
      @client  = client
      @klass   = klass
      @entries = {}
      create_entries(data["entries"])
      @_entries = @entries.to_a
    end

    def [](id)
      @entries[id] ||= fetch_entry(id)
    end

    def each
      (1..@total_size).each { |n| yield get_entry(n) }
    end

    def inspect
      "#<AW::Collection(#{@klass.to_s}) size=\"#{size}\">"
    end

  private

    def create_entries(entries)
      entries.each { |entry| @entries[entry["id"]] = @klass.new(client, entry) }
    end

    def get_entry(n)
      @_entries += fetch_next_group if needs_next_group?(n)
      @_entries[n-1]
    end

    def fetch_entry(id)
      @klass.new(client, get(File.join(base_path, id.to_s)))
    end

    def fetch_next_group(amount=20)
      path = "#{ base_path }?ws.start=#{ @_entries.size }&ws.size=#{ amount }"
      self.class.new(client, @klass, get(path)).entries.to_a
    end

    def needs_next_group?(current_index)
      current_index == @_entries.size && current_index != @total_size
    end

    def base_path
      URI.parse(@next_collection_link).path
    end

    def find_by(_attr, *args)
      matches = select { |id, e| e.send(_attr) == args.first }
      matches = matches.first.last if matches.size == 1
      matches
    end

    def method_missing(method, *args)
      method.to_s.scan /^find_by_(.+)/ do |_attr|
        return find_by(_attr.first, *args)
      end
      super
    end

    def client
      @client
    end

  end
end