module AWeber
  module Resources
    class WebFormSplitTestComponent < Resource
      attr_reader :conversion_percentage
      attr_reader :conversion_rate
      attr_reader :total_displays
      attr_reader :total_submissions
      attr_reader :total_unique_displays
      attr_reader :type
      attr_reader :unique_conversion_percentage
      attr_reader :unique_conversion_rate
      attr_reader :web_form_link
      attr_reader :weight
    end
  end
end