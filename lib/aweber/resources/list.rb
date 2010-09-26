module AWeber
  module Resources
    class List < Resource
      
      FOLLOWUP_TYPE_LINK  = File.join(AWeber.api_url, "#followup_campaign")
      BROADCAST_TYPE_LINK = File.join(AWeber.api_url, "#broadcast_campaign")
      
      attr_reader :campaigns_collection_link
      attr_reader :subscribers_collection_link
      attr_reader :name
    
      has_many :subscribers
      
      def initialize(*args)
        super(*args)
        @campaigns  = {}
        @followups  = nil
        @broadcasts = nil
      end
      
      def campaigns
        return @campaigns unless @campaigns == {}
        create_followups
        create_broadcasts
        populate_campaigns
        @campaigns
      end
      
      def broadcasts
        campaigns if @broadcasts.nil?
        @broadcasts
      end
      
      def followups
        campaigns if @followups.nil?
        @followups
      end
    
    private
      
      def create_followups
        followups  = _entries.select { |entry| is_followup? entry }
        @followups = Collection.new(Followup, {
          "entries"            => followups, 
          "total_size"         => followups.length,
          "resource_type_link" => FOLLOWUP_TYPE_LINK
        })
      end
      
      def create_broadcasts
        broadcasts  = _entries.select { |entry| is_broadcast? entry }
        @broadcasts = Collection.new(Broadcast, {
          "entries"            => broadcasts, 
          "total_size"         => broadcasts.length,
          "resource_type_link" => BROADCAST_TYPE_LINK
        })
      end
      
      def populate_campaigns
        @followups.each  { |id, followup|  @campaigns[id] = followup  }
        @broadcasts.each { |id, broadcast| @campaigns[id] = broadcast }
      end
      
      def is_followup?(entry)
        entry["resource_type_link"].split("#").last =~ /^followup/
      end
      
      def is_broadcast?(entry)
        entry["resource_type_link"].split("#").last =~ /^broadcast/
      end
      
      def _campaigns
        @_campaigns ||= get @campaigns_collection_link
      end
      
      def _entries
        _campaigns["entries"]
      end
      
    end
  end
end