module AWeber
  module Resources
    class WebFormSplitTest < Resource
      attr_reader :components_collection_link
      attr_reader :is_active
      attr_reader :name
      
      has_many :components
    end
  end
end