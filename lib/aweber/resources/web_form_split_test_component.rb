module AWeber
  module Resources
    class WebFormSplitTestComponent < Resource
      api_attr :conversion_percentage
      api_attr :is_active
      api_attr :name
      api_attr :total_displays
      api_attr :total_submissions
      api_attr :total_unique_displays
      api_attr :type
      api_attr :unique_conversion_percentage
      api_attr :web_form_link
      api_attr :weight
      
      has_one :web_form
      
      alias_attribute :is_active?, :is_active
    end
  end
end