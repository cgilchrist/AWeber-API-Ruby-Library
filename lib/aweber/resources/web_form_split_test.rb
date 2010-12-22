module AWeber
  module Resources
    class WebFormSplitTest < Resource
      api_attr :components_collection_link
      api_attr :is_active
      api_attr :name
      
      has_many :components
    end
  end
end