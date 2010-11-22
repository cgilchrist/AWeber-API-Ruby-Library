module AWeber
  module Resources
    class WebFormSplitTestComponent < Resource
      attr_reader :conversion_percentage
      attr_reader :is_active
      attr_reader :name
      attr_reader :total_displays
      attr_reader :total_submissions
      attr_reader :total_unique_displays
      attr_reader :type
      attr_reader :unique_conversion_percentage
      attr_reader :web_form_link
      attr_reader :weight
      
      has_one :web_form
      
      alias_attribute :is_active?, :is_active
    end
  end
end